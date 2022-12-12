import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia_baru/Constant/Const.dart';
import 'package:vigenesia_baru/Models/Motivasi_Model.dart';

class ItemAll extends StatefulWidget {
  const ItemAll({Key? key, required this.idUser}) : super(key: key);
  final String idUser;
  @override
  State<ItemAll> createState() => _ItemAllState();
}

String baseurl = url;
var dio = Dio();
Future<List<MotivasiModel>> getData2() async {
  var response = await dio.get('$baseurl/api/Get_motivasi/');

  print(" ${response.data}");
  if (response.statusCode == 200) {
    var getUsersData = response.data as List;
    var listUsers = getUsersData
        .map((i) => MotivasiModel.fromJson(i))
        .where((element) => element.isiMotivasi!.isNotEmpty)
        .toList();
    return listUsers;
  } else {
    throw Exception('Failed to load');
  }
}

class _ItemAllState extends State<ItemAll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: getData2(),
          builder: (BuildContext context,
              AsyncSnapshot<List<MotivasiModel>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.blue[50]!,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.07999999821186066),
                                        offset: Offset(2, 2),
                                        blurRadius: 3)
                                  ],
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Text("Dari User : " +
                                              snapshot.data![index].iduser
                                                  .toString()),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {},
                                            icon:
                                                Icon(Icons.play_arrow_outlined))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: Text(snapshot
                                              .data![index].isiMotivasi
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Text("No Data");
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

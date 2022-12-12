import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vigenesia_baru/Constant/Const.dart';
import 'package:vigenesia_baru/Models/Motivasi_Model.dart';

import 'EditPage.dart';

class ItemUser extends StatefulWidget {
  const ItemUser({
    Key? key,
    required this.idUser,
    required this.nama,
    //required this.data
  }) : super(key: key);
  final String idUser;
  final String nama;
  // final MotivasiModel data;
  @override
  State<ItemUser> createState() => _ItemUserState();
}

class _ItemUserState extends State<ItemUser> {
  String baseurl = url;
  String? id;

  var dio = Dio();
  List<MotivasiModel> listproduk = [];

  Future<List<MotivasiModel>> getData() async {
    print(widget.idUser);
    var response =
        await dio.get('$baseurl/api/Get_motivasi?iduser=${widget.idUser}/');

    print("ini data dapet ${response.data}");
    if (response.statusCode == 200) {
      print("ini data dapet ${response.data}");

      var getUsersData = response.data as List;
      var data = getUsersData
          .map((i) => MotivasiModel.fromJson(i))
          .where((element) =>
              element.isiMotivasi!.isNotEmpty &&
              element.iduser! == widget.idUser)
          .toList();
      return data;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> deletePost(String? id) async {
    dynamic data = {
      "id": id,
    };
    var response = await dio.delete('$baseurl/api/dev/DELETEmotivasi',
        data: data,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"Content-type": "application/json"}));

    print(" ${response.data}");

    var resbody = jsonDecode(response.data);
    return resbody;
  }

  Future<void> _getData() async {
    setState(() {
      getData();
      listproduk.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    print(" user : ${widget.idUser}");
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 100));
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 100));
      // if failed,use loadFailed(),if no data return,use LoadNodata()
      if (mounted) setState(() {});
      _refreshController.loadComplete();
    }

    return
        //  Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: MediaQuery.of(context).size,
        //   child: Container(
        //     padding: const EdgeInsets.only(top: 20),
        //     height: 100,
        //     width: MediaQuery.of(context).size.width,
        //     decoration: const BoxDecoration(
        //       color: Colors.blue,
        //     ),
        //     child: Row(
        //       children: [
        //         // IconButton(
        //         //   onPressed: () {
        //         //     Navigator.pop(context);
        //         //   },
        //         //   icon: const Icon(Icons.arrow_back),
        //         //   color: Colors.white,
        //         // ),
        //         const SizedBox(
        //           width: 10,
        //         ),
        //         Text(
        //           "Edit Motivasi",
        //           style: TextStyle(color: Colors.white, fontSize: 20),
        //         ),
        //         SizedBox(
        //           width: MediaQuery.of(context).size.width / 2,
        //         ),

        //         IconButton(
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           icon: const Icon(
        //             Icons.arrow_right,
        //             size: 45,
        //           ),
        //           color: Colors.white,
        //           iconSize: 30,
        //         )
        //       ],
        //     ),
        //   ),
        // ),

        //body:

        Container(
      padding: const EdgeInsets.only(top: 20),
      child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<MotivasiModel>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              print("data motivasi ini ya${snapshot.data!.length}");

              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Text(
                            "Motivasi",
                            style: TextStyle(fontSize: 22),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 230,
                          ),
                          Text(
                            "Action",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        padding: const EdgeInsets.only(bottom: 30),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 200,
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
                                  child: Text(
                                    snapshot.data![index].isiMotivasi
                                        .toString(),
                                    maxLines: 7,
                                  ),
                                ),
                                Row(children: [
                                  TextButton(
                                    child: Icon(Icons.settings),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                EditPage(
                                                    id: snapshot
                                                        .data![index].id!,
                                                    isi_motivasi: snapshot
                                                        .data![index]
                                                        .isiMotivasi!),
                                          ));
                                    },
                                  ),
                                  TextButton(
                                    child: Icon(Icons.delete),
                                    onPressed: () {
                                      deletePost(snapshot.data![index].id)
                                          .then((value) => {
                                                if (value != null)
                                                  {
                                                    Flushbar(
                                                      message:
                                                          "Berhasil Dihapus",
                                                      duration: Duration(
                                                          milliseconds: 10),
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                      flushbarPosition:
                                                          FlushbarPosition.TOP,
                                                    ).show(context)
                                                  }
                                              });
                                    },
                                  )
                                ]),
                              ]);
                        }),
                  ],
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Text("No Data");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
    // );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia_baru/Constant/Const.dart';
import 'package:vigenesia_baru/Models/Motivasi_Model.dart';

import 'package:vigenesia_baru/Screens/motivasi/item.all.dart';
import 'package:vigenesia_baru/layout/drawerpage.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({Key? key, required this.idUser, required this.nama})
      : super(key: key);
  final String idUser;
  final String nama;
  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  String baseurl = url;
  var dio = Dio();
  List<MotivasiModel> ass = [];
  TextEditingController titleController = TextEditingController();

  Future<dynamic> sendMotivasi(String isi) async {
    Map<String, dynamic> body = {"isi_motivasi": isi, "iduser": widget.idUser};

    try {
      Response response = await dio.post("$baseurl/api/dev/POSTmotivasi",
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print("Respon -> ${response.data} + ${response.statusCode}");
      return response;
    } catch (e) {
      print("Error di -> $e");
    }
  }

  List<MotivasiModel> listproduk = [];

  Future<List<MotivasiModel>> getData() async {
    var response = await dio
        .get('$baseurl/api/GET_motivasi?iduser=${widget.idUser.isNotEmpty}');

    print(" ${response.data["isi_motivasi"]}");
    if (response.statusCode == 200) {
      var getUsersData = response.data as List;
      var data = getUsersData.map((i) => MotivasiModel.fromJson(i)).toList();
      return data;
    } else {
      throw Exception('Failed to load');
    }
  }

  TextEditingController isiController = TextEditingController();
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
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              "Vigenesia",
              style: TextStyle(color: Colors.blue),
            ),
            const Spacer(),
            TextButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                _getData();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.blue.withOpacity(0.7),
          size: 30,
        ),
      ),
    
      drawer: DrawerPage(idUser: widget.idUser, nama: widget.nama),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const SizedBox(
                      height: 30,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Hallo! \n\n${widget.nama}",
                    //       style: TextStyle(
                    //           fontSize: 22, fontWeight: FontWeight.w500),
                    //     ),
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     IconButton(
                    //         onPressed: () {
                    //           print(widget.idUser);
                    //           Navigator.push(
                    //               context,
                    //               new MaterialPageRoute(
                    //                   builder: (
                    //                 BuildContext context,
                    //               ) =>
                    //                       // ListView.builder(
                    //                       //   shrinkWrap: true,
                    //                       //   scrollDirection: Axis.vertical,
                    //                       //   itemCount: listproduk.length,
                    //                       //   itemBuilder: (BuildContext context, int index) {
                    //                       //     return
                    //                       new ItemUser(
                    //                         idUser: widget.idUser,
                    //                         nama: widget.nama,
                    //                         // data: listproduk.,
                    //                       )
                    //                   //         ;
                    //                   //   },
                    //                   // ),
                    //                   ));
                    //         },
                    //         icon: Icon(
                    //           Icons.edit_notifications,
                    //           size: 35,
                    //           color: Colors.blue,
                    //         )),
                    //     TextButton(
                    //         child: Icon(Icons.logout),
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //           Navigator.push(
                    //               context,
                    //               new MaterialPageRoute(
                    //                   builder: (BuildContext context) =>
                    //                       new Login()));
                    //         })
                    //   ],
                    // ),

                    // SizedBox(height: 20),
                    // FormBuilderTextField(
                    //   controller: isiController,
                    //   name: "isi_motivasi",
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(
                    //         10,
                    //       ),
                    //     ),
                    //     contentPadding: EdgeInsets.only(left: 10),
                    //   ),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: ElevatedButton(
                    //     onPressed: () async {
                    //       if (isiController.text.toString().isEmpty) {
                    //         Flushbar(
                    //           message: "Tidak Boleh Kosong",
                    //           duration: Duration(seconds: 2),
                    //           backgroundColor: Colors.redAccent,
                    //           flushbarPosition: FlushbarPosition.TOP,
                    //         ).show(context);
                    //       } else if (isiController.text.toString().isNotEmpty) {
                    //         await sendMotivasi(
                    //           isiController.text.toString(),
                    //         ).then((value) => {
                    //               if (value != null)
                    //                 {
                    //                   Flushbar(
                    //                     message: "Berhasil Submit",
                    //                     duration: Duration(seconds: 2),
                    //                     backgroundColor: Colors.greenAccent,
                    //                     flushbarPosition: FlushbarPosition.TOP,
                    //                   ).show(context)
                    //                 }
                    //             });
                    //       }

                    //       print("Sukses");
                    //     },
                    //     child: Text("Submit"),
                    //   ),
                    // ),

                    // FormBuilderRadioGroup(
                    //     onChanged: (value) {
                    //       setState(() {
                    //         trigger = value.toString();
                    //         print(" Hasilnya --> $trigger");
                    //       });
                    //     },
                    //     name: "_",
                    //     options: ["Motivasi By All", "Motivasi By User"]
                    //         .map((e) => FormBuilderFieldOption(
                    //             value: e, child: Text(e)))
                    //         .toList()),
                    // trigger == "Motivasi By All" ?
                    //  ItemAll()
                    //   : Container(),
                    // trigger == "Motivasi By User"
                    //     ?
                    //       ItemUser(idUser: widget.idUser, nama: widget.nama,)
                    //     : Container(),
                   
                    ItemAll(
                      idUser: widget.idUser,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia_baru/Constant/Const.dart';

import 'package:vigenesia_baru/Screens/motivasi/item.user.dart';
import 'package:vigenesia_baru/layout/drawerpage.dart';

class PostMotivasi extends StatefulWidget {
  const PostMotivasi({Key? key, required this.idUser, required this.nama})
      : super(key: key);
  final String idUser;
  final String nama;
  @override
  State<PostMotivasi> createState() => _PostMotivasiState();
}

class _PostMotivasiState extends State<PostMotivasi> {
  String baseurl = url;
  var dio = Dio();

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

  TextEditingController isiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.blue.withOpacity(0.7),
          size: 30,
        ),
      ),
      drawer: DrawerPage(idUser: widget.idUser, nama: widget.nama),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: FormBuilderTextField(
                  controller: isiController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  maxLength: 2000,
                  autofocus: true,
                  name: "isi_motivasi",
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isiController.text.toString().isEmpty) {
                        Flushbar(
                          message: "Tidak Boleh Kosong",
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.redAccent,
                          flushbarPosition: FlushbarPosition.TOP,
                        ).show(context);
                      } else if (isiController.text.toString().isNotEmpty) {
                        await sendMotivasi(
                          isiController.text.toString(),
                        ).then((value) => {
                              if (value != null)
                                {
                                  Flushbar(
                                    message: "Berhasil Submit",
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.greenAccent,
                                    flushbarPosition: FlushbarPosition.TOP,
                                  ).show(context)
                                }
                            });
                      }

                      print("Sukses");
                    },
                    child: Text("Submit"),
                  ),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.only(top: 20, bottom: 20),
              //   child: FutureBuilder(
              //       future: getData(),
              //       builder: (BuildContext context,
              //           AsyncSnapshot<List<MotivasiModel>> snapshot) {
              //         if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              //           print("data motivasi ini ya${snapshot.data!.length}");

              //           return Column(
              //             children: [
              //               ListView.builder(
              //                   padding: const EdgeInsets.only(bottom: 30),
              //                   scrollDirection: Axis.vertical,
              //                   shrinkWrap: true,
              //                   itemCount: snapshot.data!.length,
              //                   itemBuilder:
              //                       (BuildContext context, int index) {
              //                     return Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceBetween,
              //                         children: <Widget>[
              //                           Container(
              //                             width: 200,
              //                             padding: const EdgeInsets.all(10),
              //                             margin: const EdgeInsets.symmetric(
              //                                 horizontal: 15, vertical: 15),
              //                             decoration: BoxDecoration(
              //                               color: Colors.white,
              //                               border: Border.all(
              //                                 width: 1,
              //                                 color: Colors.blue[50]!,
              //                               ),
              //                               boxShadow: const [
              //                                 BoxShadow(
              //                                     color: Color.fromRGBO(0, 0,
              //                                         0, 0.07999999821186066),
              //                                     offset: Offset(2, 2),
              //                                     blurRadius: 3)
              //                               ],
              //                               borderRadius:
              //                                   BorderRadius.circular(
              //                                 10,
              //                               ),
              //                             ),
              //                             child: Text(
              //                               snapshot.data![index].isiMotivasi
              //                                   .toString(),
              //                               maxLines: 7,
              //                             ),
              //                           ),
              //                           Row(children: [
              //                             TextButton(
              //                               child: Icon(Icons.settings),
              //                               onPressed: () {
              //                                 Navigator.push(
              //                                     context,
              //                                     MaterialPageRoute(
              //                                       builder: (BuildContext
              //                                               context) =>
              //                                           EditPage(
              //                                               id: snapshot
              //                                                   .data![index]
              //                                                   .id!,
              //                                               isi_motivasi: snapshot
              //                                                   .data![index]
              //                                                   .isiMotivasi!),
              //                                     ));
              //                               },
              //                             ),
              //                             TextButton(
              //                               child: Icon(Icons.delete),
              //                               onPressed: () {
              //                                 deletePost(snapshot
              //                                         .data![index].id)
              //                                     .then((value) => {
              //                                           if (value != null)
              //                                             {
              //                                               Flushbar(
              //                                                 message:
              //                                                     "Berhasil Dihapus",
              //                                                 duration: Duration(
              //                                                     milliseconds:
              //                                                         10),
              //                                                 backgroundColor:
              //                                                     Colors
              //                                                         .redAccent,
              //                                                 flushbarPosition:
              //                                                     FlushbarPosition
              //                                                         .TOP,
              //                                               ).show(context)
              //                                             }
              //                                         });
              //                               },
              //                             )
              //                           ]),
              //                         ]);
              //                   }),
              //             ],
              //           )

              //               //,
              //               ;
              //         } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              //           return Text("No Data");
              //         } else {
              //           return Center(child: CircularProgressIndicator());
              //         }
              //       }),
              // ),
              ItemUser(idUser: widget.idUser, nama: widget.nama)
            ],
          ),
        ),
      ),
    );
  }
}

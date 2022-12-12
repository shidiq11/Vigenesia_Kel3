import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia_baru/Constant/Const.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, required this.id, required this.isi_motivasi})
      : super(key: key);
  final String id;
  final String isi_motivasi;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String baseurl = url;

  var dio = Dio();
  Future<dynamic> putPost(String isiMotivasi, String ids) async {
    Map<String, dynamic> data = {"isi_motivasi": isiMotivasi, "id": ids};
    var response = await dio.put('$baseurl/api/dev/PUTmotivasi',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ));

    print("---> ${response.data} + ${response.statusCode}");
    return response.data;
  }

  TextEditingController isiMotivasiC = TextEditingController();

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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.blue[50]!,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.07999999821186066),
                          offset: Offset(2, 2),
                          blurRadius: 3)
                    ],
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Text(
                    widget.isi_motivasi.toString(),
                    maxLines: 7,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: FormBuilderTextField(
                    name: "isi_motivasi",
                    maxLines: 8,
                    maxLength: 2000,
                    autofocus: true,
                    controller: isiMotivasiC,
                    decoration: InputDecoration(
                      labelText: "New Data",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        putPost(isiMotivasiC.text, widget.id).then((value) => {
                              if (value != null)
                                {
                                  Navigator.pop(context),
                                  Flushbar(
                                    message: "Berhasil Diupdate & Refresh Dulu",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.green,
                                    flushbarPosition: FlushbarPosition.TOP,
                                  ).show(context)
                                }
                            });
                      },
                      child: Text("Submit")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

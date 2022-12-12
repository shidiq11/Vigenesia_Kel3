import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia_baru/Constant/Const.dart';
import 'package:vigenesia_baru/Models/Login_Model.dart';
import 'package:vigenesia_baru/Screens/MainScreens.dart';
import 'package:vigenesia_baru/Screens/auth/register/Register.dart';
import 'package:vigenesia_baru/routers.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? nama;
  String? id;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<dynamic> postLogin(String email, String password) async {
    var dio = Dio();
    String baseurl = url;

    Map<String, dynamic> data = {"email": email, "password": password};

    try {
      final response = await dio.post("$baseurl/api/login/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));

      print("Respon -> ${response.data} + ${response.statusCode}");
      if (response.statusCode == 200) {
        final loginModel = LoginModels.fromJson(response.data);

        return loginModel;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Masuk ",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/image/wk.png"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(height: 50),
                Center(
                  child: Form(
                    key: _fbKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: "email",
                            controller: emailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(),
                                labelText: "Email"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            obscureText: true,
                            name: "password",
                            controller: passwordController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Gapunya akun ? Daftar laah',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                TextSpan(
                                    text: 'Sign Up',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Daftar()));
                                      },
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await postLogin(emailController.text,
                                          passwordController.text)
                                      .then((value) => {
                                            if (value != null)
                                              {
                                                setState(() {
                                                  nama = value.data.nama;
                                                  id = value.data.iduser;
                                                  pushPageRemove(
                                                      context,
                                                      MainScreens(
                                                        nama: nama!,
                                                        idUser: id!,
                                                      ));
                                                })
                                              }
                                            else if (value == null)
                                              {
                                                Flushbar(
                                                  message:
                                                      "Check Your Email / Password",
                                                  duration:
                                                      Duration(seconds: 5),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                ).show(context)
                                              }
                                          });
                                },
                                child: Text("Sign In")),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

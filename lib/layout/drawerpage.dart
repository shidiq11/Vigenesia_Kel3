import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:vigenesia_baru/Screens/MainScreens.dart';
import 'package:vigenesia_baru/Screens/auth/login/Login.dart';
import 'package:vigenesia_baru/Screens/motivasi/postmotivasi.dart';
import 'package:vigenesia_baru/routers.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key, required this.idUser, required this.nama})
      : super(key: key);
  final String idUser;
  final String nama;
  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      theme: SidebarXTheme(
        width: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.white,
        textStyle: TextStyle(color: Colors.blue.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
        ),
        height: double.infinity,
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.red,
          ),
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.amber],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.blue.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.blue,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 230,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text(
              "${widget.nama}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      controller: SidebarXController(selectedIndex: 10, extended: true),
      items: [
        SidebarXItem(
            icon: Icons.home,
            label: 'Beranda',
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (
                    BuildContext context,
                  ) =>
                          new MainScreens(
                            idUser: widget.idUser,
                            nama: widget.nama,
                          )));
            }),
        SidebarXItem(
            icon: Icons.add_comment,
            label: 'Posting',
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (
                    BuildContext context,
                  ) =>
                          new PostMotivasi(
                            idUser: widget.idUser,
                            nama: widget.nama,
                          )));
            }),
        SidebarXItem(
            icon: Icons.logout_outlined,
            label: 'Keluar',
            onTap: () {
              pushPageRemove(context, Login());
              // Navigator.pushReplacement(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (
              //       BuildContext context,
              //     ) =>
              //             new Login()));
            }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zarashop/pages/home_page.dart';
import 'package:zarashop/pages/main_page.dart';
import '../model/Utils.dart';

import '../register_page/phone.dart';
import '../service/auth_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void doSignOut() {
    AuthService.signOutUser().then((value) => {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage())),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              bool yes = await Utils.commanDialog(context, "Profildan chiqish",
                  "Profildan chiqmoqchimisiz?", "Ha", "Yo'q", false);
              if (yes) {
                doSignOut();
              }
            },
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.black,
            ),
          )
        ],
        title: const Text("Profile",
            style: TextStyle(
                color: Colors.black, fontFamily: "billabong", fontSize: 28)),
      ),
    );
  }
}

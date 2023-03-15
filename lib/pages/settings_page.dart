import 'package:flutter/material.dart';
import '../model/Utils.dart';
import '../registerpage/phone.dart';
import '../service/auth_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String Name = "";
  String LastName = "";
  String Gmail = "";

  void doSignOut() {
    print(1);
    AuthService.signOutUser().then((value) => {
          print(2),
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen())),
          print(3),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
          Color.fromRGBO(248, 184, 225, 1.0),
          Color.fromRGBO(69, 172, 243, 1.0)
        ]))),
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
      body: Center(
        child: Text(Name),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zarashop/pages/home_page.dart';
import 'package:zarashop/pages/main_page.dart';
import 'package:zarashop/pages/splash_page.dart';
import 'package:zarashop/register_page/phone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      color: Colors.indigo[900],
    );
  }
}
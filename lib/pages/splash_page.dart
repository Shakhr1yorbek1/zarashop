
import 'package:flutter/material.dart';
import 'package:zarashop/pages/home_page.dart';
import '../auth_pages/signin_page.dart';
import '../register_page/phone.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    initPage();
    super.initState();
  }

  bool isLogged = false;
  Future<void> initPage() async {
    await Future.delayed(const Duration(seconds: 2),);
    if (isLogged) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193, 53, 132, 1),
                Color.fromRGBO(131, 58, 180, 1),
              ]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
               height: 150,
               width: 150,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15),
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(32),
                 child: Image(
                   image: AssetImage("assets/images/rasm.jpg"),
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
}

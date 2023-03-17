// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../service/Utils.dart';
import '../model/user_model.dart';
import '../pages/main_page.dart';
import '../service/data_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController Lastnamecontroller = TextEditingController();
  TextEditingController Gmailcontroller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";
  bool isLoading = false;

  static final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Ro'yxatdan o'tish"),
              flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                Color.fromRGBO(248, 184, 225, 1.0),
                Color.fromRGBO(69, 172, 243, 1.0)
              ]))),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image
                    const Image(
                      image: AssetImage("assets/images/rasm.png"),
                    ),

                    //#fullName
                    // TextField(
                    //   controller: Namecontroller,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Name',
                    //     prefix: Padding(
                    //       padding: EdgeInsets.all(4),
                    //     ),
                    //   ),
                    //   maxLength: 20,
                    // ),
                    //#email
                    // TextField(
                    //   controller: Lastnamecontroller,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Last Name',
                    //     prefix: Padding(
                    //       padding: EdgeInsets.all(4),
                    //     ),
                    //   ),
                    //   maxLength: 20,
                    // ),
                    //#password
                    // TextField(
                    //   controller: Gmailcontroller,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Gmail (Optional)',
                    //     prefix: Padding(
                    //       padding: EdgeInsets.all(4),
                    //     ),
                    //   ),
                    //   maxLength: 20,
                    // ),

                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('+998'),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    Visibility(
                      visible: otpVisibility,
                      child: TextField(
                        controller: otpController,
                        decoration: const InputDecoration(
                          hintText: 'OTP',
                          prefix: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(''),
                          ),
                        ),
                        maxLength: 6,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: () async {
                        if (otpVisibility) {
                          await verifyOTP();
                          // await register(user!.uid);
                        } else {
                          loginWithPhone();
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        (isLoading)
            ? Scaffold(
                backgroundColor: Colors.grey.withOpacity(.3),
                body: const Center(
                  child: CircularProgressIndicator(),
                ))
            : const SizedBox(),
      ],
    );
  }

  void addProfile() async {
    String name = Namecontroller.text;
    String LastName = Lastnamecontroller.text;
    String Gmaill = Gmailcontroller.text;

    if (name.isEmpty || LastName.isEmpty || phoneController.text.isEmpty) {
      Utils.fToast("Ma'lumotlar to'liq emas");
      return;
    }
  }

  void loginWithPhone() async {
    String name = Namecontroller.text;
    String LastName = Lastnamecontroller.text;
    String Gmaill = Gmailcontroller.text;

    if (name.isEmpty || LastName.isEmpty || phoneController.text.isEmpty) {
      Utils.fToast("Ma'lumotlar to'liq emas");
      return;
    }

    setState(() {
      isLoading = true;
    });

    auth.verifyPhoneNumber(
      phoneNumber: "+998" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("Muoffaqiyatli ro'yxatdan o'tildi");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {
          isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOTP() async {
    setState(() {
      isLoading = false;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () async {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          bool exist = await DataService.existUser(user!.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(dataSaved: exist),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }

  void LogOut() async {
    await _auth.signOut();
  }

  Future<void> register(String uid) async {
    String phoneN = phoneController.text.trim();
    String name = Namecontroller.text.trim();
    String lastname = Lastnamecontroller.text.trim();
    String gmail = Gmailcontroller.text.trim();



    Users users = Users(
      phone: phoneN,
      name: name,
      lastName: lastname,
    );
    users.uid = uid;
    print(users.uid);
    await DataService.storeUser(users);

  }
}

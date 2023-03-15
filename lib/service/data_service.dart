

 import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class DataService {
  static final _firestore=FirebaseFirestore.instance;

  static Future storeUser(Users users) async {
   await _firestore.collection("users").doc(users.uid).set(users.toJson());
  }
 }
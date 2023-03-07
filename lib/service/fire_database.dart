import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' hide Query;
import 'package:firebase_database/firebase_database.dart';
import '../model/product_model.dart';
import 'auth_service.dart';

class DataService {

  static final _firestore=FirebaseFirestore.instance;
  static String folderAdmin="admin";

  static Future<List<Product>> getProduct() async {
    List<Product> p = [];
    var docs = await _firestore.collection("Products").get();
    for (var a in docs.docs) {
      p.add(Product.fromJson(a.data()));
    }
    return p;
  }



  static Future<List<Product>> getOfCategory(String categoryName) async {
    List<Product> p = [];
    var docs = await _firestore.collection("Products").where("category", isEqualTo: categoryName).get();
    for (var a in docs.docs) {
      print(a.data()["name"]);
      p.add(Product.fromJson(a.data()));
    }
    return p;
  }



}

class RTDBService{
  static final _database = FirebaseDatabase.instance.ref();

  static Future<List<String>> getCategory() async {
    List<String> items=[];
    Query query=_database.ref.child("category");
    DatabaseEvent event=await query.once();
    var snapshot=event.snapshot;
    int index=0;
    for (var a in snapshot.children) {
      items.add(a.value.toString());
      index+=1;
    }
    return items;
  }
}
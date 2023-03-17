import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zarashop/model/product_model.dart';
import '../model/user_model.dart';
import 'auth_service.dart';

class DataService {
  static final _firestore = FirebaseFirestore.instance;
  static String folderUser = "Users";

  static Future<bool> existUser(String uid) async {
    var doc = await _firestore.collection(folderUser).doc(uid).get();
    return doc.exists;
  }

  static Future<Users> loadMember() async {
    String? uid = AuthService.currentUserId();
    var value = await _firestore.collection(folderUser).doc(uid).get();
    Users users = Users.fromJson(value.data()!);
    return users;
  }

  static Future storeUser(Users users) async {
    await _firestore.collection("Users").doc(users.uid).set(users.toJson());
  }

  // static Future likePost(Product product, bool isLiked) async {
  //   String myUid = AuthService.currentUserId();
  //   String uid = product.uid!;
  //   String postId = product.id!;
  //   List<Map<String, dynamic>> likedPostsData = await loadLikedPostsData();
  //   List posts = [];
  //
  //   if (likedPostsData.isNotEmpty ) {
  //     Map<String, dynamic> userAndPosts = likedPostsData.firstWhere((e) => e['uid'] ==uid, orElse: () => {});
  //     if(userAndPosts.isNotEmpty) posts = userAndPosts['posts'];
  //   }
  //
  //   if (isLiked) {
  //     posts.add(postId);
  //   } else {
  //     posts.remove(postId);
  //   }
  //   await _firestore.collection(folderUser).doc(myUid).collection(folderLike).doc(uid).set({
  //     "uid" : uid,
  //     "posts" : posts,
  //   });
  //
  // }
}

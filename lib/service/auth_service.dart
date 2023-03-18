import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<void> signOutUser() async {
    await _auth.signOut();
  }

  static bool isLoggedIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  static String? currentUserId() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser!.uid;
  }
}

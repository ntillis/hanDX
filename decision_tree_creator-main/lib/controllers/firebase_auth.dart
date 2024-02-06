import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN IN METHOD
  static Future signIn(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static String? getUid() {
    return _auth.currentUser?.uid;
  }

  //SIGN OUT METHOD
  static Future signOut() async {
    await _auth.signOut();
  }
}

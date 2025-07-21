import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{

  final auth = FirebaseAuth.instance;
  final googleSignin = GoogleSignIn();

  Future<bool> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignin.signIn();

      if(googleSignInAccount == null){
        return false;
      }

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken, 
        idToken: googleSignInAuthentication.idToken
      );
      
      await auth.signInWithCredential(authCredential);
      return true;
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> autoSignInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignin.signInSilently();
      if (googleSignInAccount == null) {
        return false;
      }
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(authCredential);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }

  googleSignOut() async {
    await auth.signOut();
    await googleSignin.signOut();
  }
}
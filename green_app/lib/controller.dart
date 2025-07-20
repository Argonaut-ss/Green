import 'package:firebase_auth/firebase_auth.dart';

class SignInResult {
  final UserCredential? userCredential;
  final String? errorMessage;

  SignInResult({this.userCredential, this.errorMessage});
}

class SignInController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<SignInResult> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SignInResult(userCredential: userCredential);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'Sign in failed. Please try again.';
      }
      return SignInResult(errorMessage: message);
    } catch (e) {
      return SignInResult(errorMessage: 'An unexpected error occurred.');
    }
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
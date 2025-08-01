import 'package:cloud_firestore/cloud_firestore.dart';
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

class SignupController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('User data added to Firestore');
        return null; // Success
      } else {
        return 'User creation failed';
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      print('Unexpected signup error: $e');
      return 'An unexpected error occurred';
    }
  }
}

Future<String?> deleteAccountAndData() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 'No user signed in';

    // Delete Firestore user document
    await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

    // Delete Auth user
    await user.delete();

    return null; // Success
  } on FirebaseAuthException catch (e) {
    return e.message;
  } catch (e) {
    print('Delete account error: $e');
    return 'An unexpected error occurred';
  }
}

class AddPesananAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> addPesananAPI({
    required String namaPesanan,
    required String alamat,
    required String jasa,
    required String deliv,
    required String catatan,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('pesanan').doc(user.uid).set({
          'namaPesanan': namaPesanan,
          'alamat': alamat,
          'jasa': jasa,
          'deliv': deliv,
          'catatan': catatan,
        });
        print('Pesanan data added to Firestore');
        return null; // Success
      } else {
        return 'Pesananan failed';
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      print('Unexpected error: $e');
      return 'An unexpected error occurred';
    }
  }
}
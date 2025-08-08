import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{

  final auth = FirebaseAuth.instance;
  final googleSignin = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

      final UserCredential userCredential = await auth.signInWithCredential(authCredential);

      // Save user data to Firestore
      if (userCredential.user != null) {
        await _saveUserToFirestore(userCredential.user!, googleSignInAccount);
      }

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
      final UserCredential userCredential = await auth.signInWithCredential(authCredential);

      // Save user data to Firestore
      if (userCredential.user != null) {
        await _saveUserToFirestore(userCredential.user!, googleSignInAccount);
      }

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> _saveUserToFirestore(User user, GoogleSignInAccount googleAccount) async {
    try {
      // Check if user document already exists
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        final String role = 'client';

        // Create new user document
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName ?? googleAccount.displayName ?? 'Unknown',
          'email': user.email ?? googleAccount.email,
          'photoURL': user.photoURL ?? googleAccount.photoUrl,
          'phone': user.phoneNumber ?? '',
          'provider': 'google',
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Google user data saved to Firestore');
      } else {
        // Update last login time for existing user
        await _firestore.collection('users').doc(user.uid).update({
          'name': user.displayName ?? googleAccount.displayName ?? userDoc.data()?['name'],
          'email': user.email ?? googleAccount.email,
          'photoURL': user.photoURL ?? googleAccount.photoUrl,
        });
        print('Google user login time updated in Firestore');
      }
    } catch (e) {
      print('Error saving Google user to Firestore: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        final snapshot = await _firestore.collection('users').doc(user.uid).get();
        return snapshot.data();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }

  Future<bool> updateUserData({
    String? name,
    String? phone,
    String? email,
    String? location,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) return false;

      final Map<String, dynamic> updatedData = {};

      if (name != null && name.isNotEmpty) updatedData['name'] = name;
      if (phone != null && phone.isNotEmpty) updatedData['phone'] = phone;
      if (email != null && email.isNotEmpty) updatedData['email'] = email;
      if (location != null && location.isNotEmpty) updatedData['location'] = location;

      await _firestore.collection('users').doc(user.uid).update(updatedData);
      return true;
    } catch (e) {
      print('Error updating user data: $e');
      return false;
    }
  }


  Future<String> getUserRole() async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        return 'client'; // Default if not signed in
      }

      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final data = userDoc.data();
      if (data != null && data.containsKey('role')) {
        return data['role'] ?? 'client';
      } else {
        return 'client'; // Default if role not found
      }
    } catch (e) {
      print("Error fetching user role: $e");
      return 'client';
    }
  }

  googleSignOut() async {
    await auth.signOut();
    await googleSignin.signOut();
  }

}
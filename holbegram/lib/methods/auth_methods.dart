// tasks 6: auth_methods.dart
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthMethode {
  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login
  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      // chequea si esta empty
      if (email.isEmpty || password.isEmpty) {
        return "Please fill all the fields";
      }

      // Firebase login
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Success
      res = "success";
    } on FirebaseAuthException catch (e) {
      res = e.message ?? "Firebase error";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // Sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    String res = "Some error occurred";

    try {
      // Chequea si esta empty
      if (email.isEmpty || password.isEmpty || username.isEmpty) {
        return "Please fill all the fields";
      }

      // Create user with Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user
      User user = userCredential.user!;

      // Create Users model
      Users users = Users(
        uid: user.uid,
        email: email,
        username: username,
        bio: '',
        photoUrl: '',
        followers: [],
        following: [],
        posts: [],
        saved: [],
        searchKey: username[0].toUpperCase(),
      );

      // Save user to Firestore
      await _firestore
          .collection("users")
          .doc(user.uid)
          .set(users.toJson());

      // Success
      res = "success";
    } on FirebaseAuthException catch (e) {
      res = e.message ?? "Firebase error";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<Users> getUserDetails() async {
    final User currentUser = _auth.currentUser!;
    final DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return Users.fromSnap(snap);
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthOperation {
  Future<String> register(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return "succses";
    } on FirebaseAuthException catch (e) {
      log("enter heeeeeeeeeeeeeeeer");
      log(e.code);
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-not-found':
          return 'User not found.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'invalid-credential':
          return 'Wrong password.';
        case 'operation-not-allowed':
          return 'Operation not allowed.';
        case 'network-request-failed':
          return 'Network request failed. Please check your internet connection.';
        default:
          return 'An unexpected error occurred. Please try again later.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return "succses";
    } on FirebaseAuthException catch (e) {
      log("enter heeeeeeeeeeeeeeeer");
      log(e.code);
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-not-found':
          return 'User not found.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'invalid-credential':
          return 'Wrong password.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'operation-not-allowed':
          return 'Operation not allowed.';
        case 'network-request-failed':
          return 'Network request failed. Please check your internet connection.';
        default:
          return 'An unexpected error occurred. Please try again later.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> forgetPassword(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      return "succses";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ' No user found for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return 'null';
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}


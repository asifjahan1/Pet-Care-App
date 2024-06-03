import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user with email and password
  Future<bool> register(
      BuildContext context, String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        // Show a Snackbar message if email or password is empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide both email and password.')),
        );
        return false; // Registration failed
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await sendEmailVerification();

      return true; // Registration successful
    } catch (e) {
      print("Error registering user: $e");
      return false; // Registration failed
    }
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print("Error sending email verification: $e");
    }
  }

  // Login user with email and password
  Future<bool> login(
      BuildContext context, String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        // Show a Snackbar message if email or password is empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide both email and password.')),
        );
        return false; // Login failed
      }

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true; // Login successful
    } catch (e) {
      print("Error logging in: $e");
      return false; // Login failed
    }
  }

  // Logout user
  Future<void> logout() async {
    await _auth.signOut();
  }
}

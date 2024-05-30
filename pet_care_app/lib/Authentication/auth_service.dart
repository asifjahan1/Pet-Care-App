//using Shared-preference
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user with email and password
  Future<bool> register(String email, String password) async {
    try {
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
  Future<bool> login(String email, String password) async {
    try {
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

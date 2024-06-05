// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/Authentication/auth_service.dart';
import 'package:pet_care_app/Pages/Doctor/doctor_login.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({super.key});

  @override
  _DoctorRegistrationState createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> allowedDoctorEmails = [
    'tas.tutul@gmail.com',
    'tas.tutul786@gmail.com',
    'tas.tutulvet@gmail.com',
    'asifjahan307@gmail.com',
    // '3332asif1@gmail.com',
  ];

  // String? validateEmail(String? value) {
  //   if (value == null || !allowedDoctorEmails.contains(value)) {
  //     return 'Only authorized doctors can register.';
  //   }
  //   return null;
  // }

  String? validateEmail(String? value) {
    if (value == null || !allowedDoctorEmails.contains(value)) {
      return 'Only authorized doctors can register.';
    }
    return null;
  }

  void _registerDoctor() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (validateEmail(email) != null) {
      _showSnackbar('Only authorized doctors can register.');
      return;
    }

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Please enter email and password');
      return;
    }

    try {
      // Check if the email is already registered
      final isEmailRegistered = await _isEmailRegistered(email);
      if (isEmailRegistered) {
        _showSnackbar(
            'This email is already registered. Please log in instead.');
        return;
      }

      // Attempt to create user in Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful creation, store the user details in Firestore
      await _firestore.collection('doctors').doc(userCredential.user!.uid).set({
        'email': email,
      });

      _showSnackbar('Registration successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DoctorPage()),
      );
    } on FirebaseAuthException catch (e) {
      _showSnackbar('Error registering doctor: ${e.message}');
    } catch (e) {
      _showSnackbar('Error registering doctor: $e');
    }
  }

  Future<bool> _isEmailRegistered(String email) async {
    try {
      // Check if the email exists in Firebase Auth
      await _auth.fetchSignInMethodsForEmail(email);
      return true; // Email is registered
    } on FirebaseAuthException catch (_) {
      return false; // Email is not registered
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.green,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Doctor Registration',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Doctor Email',
                      prefixIcon: const Icon(Icons.email, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Please Enter Password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    elevation: 5,
                    color: Colors.green,
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: _registerDoctor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "SignUp",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Already Have an Account? ',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: 'Login!',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DoctorPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

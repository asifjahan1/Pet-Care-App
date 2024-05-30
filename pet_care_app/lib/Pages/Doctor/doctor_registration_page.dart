import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/Pages/Doctor/doctor_login.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({required Key key}) : super(key: key);

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List of allowed email addresses for doctors
  List<String> allowedDoctorEmails = [
    'tas.tutul@gmail.com',
    'tas.tutul786@gmail.com',
    'tas.tutulvet@gmail.com',
    'asifjahan307@gmail.com',
    // Add more allowed email addresses as needed
  ];

  String? validateEmail(String? value) {
    if (value == null || !allowedDoctorEmails.contains(value)) {
      return 'Only authorized doctors can register.';
    }
    return null;
  }

  void _registerDoctor() async {
    try {
      // Create Firebase user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Add doctor details to Firestore
      await _firestore.collection('doctors').doc(userCredential.user!.uid).set({
        'email': emailController.text,
        // Add more doctor details here if needed
      });

      // Navigate to doctor page after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DoctorPage()),
      );
    } catch (e) {
      // Handle registration errors here
      print('Error registering doctor: $e');
    }
  }

  @override
  void dispose() {
    // Dispose of the email and password controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: validateEmail,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true, // Hide password text
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (validateEmail(emailController.text) == null) {
                  _registerDoctor();
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

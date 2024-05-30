import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/Authentication/auth_service.dart';
import 'package:pet_care_app/Pages/Doctor/doctor_login.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({Key? key}) : super(key: key);

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List of allowed email addresses for doctors
  final List<String> allowedDoctorEmails = [
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Registration Error!',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _registerDoctor() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (validateEmail(email) != null) {
      _showErrorDialog('Only authorized doctors can register.');
      return;
    }

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter email and password');
      return;
    }

    try {
      // Create Firebase user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add doctor details to Firestore
      await _firestore.collection('doctors').doc(userCredential.user!.uid).set({
        'email': email,
        // Add more doctor details here if needed
      });

      // Show success message and navigate to doctor page after successful registration
      _showSuccessDialog();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showErrorDialog(
            'The email address is already in use by another account.');
      } else {
        _showErrorDialog('Error registering doctor: ${e.message}');
      }
    } catch (e) {
      _showErrorDialog('Error registering doctor: $e');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful'),
          content: Text('Your registration was successful.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorPage()),
                );
              },
            ),
          ],
        );
      },
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Email field
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
                    // Password field
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                      onPressed: () async {
                        _registerDoctor();
                      },
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
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Login!',
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                              //decoration: TextDecoration.underline,
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
          ],
        ),
      ),
    );
  }
}

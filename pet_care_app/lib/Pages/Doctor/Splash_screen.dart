// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pet_care_app/Pages/Doctor/doctor_login.dart';
import 'package:pet_care_app/Pages/Doctor/doctor_registration_page.dart';

class DoctorLogReg extends StatelessWidget {
  const DoctorLogReg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              elevation: 5,
              color: Colors.green,
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              //minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorRegistration(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Doctor Registration",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              elevation: 5,
              color: Colors.green,
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              //minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorPage(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Doctor Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

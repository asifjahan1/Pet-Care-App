import 'package:flutter/material.dart';
import 'package:pet_care_app/Pages/Doctor/doctor_registration_page.dart';
import 'package:pet_care_app/Pages/Patients/patients_registration_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Pet Care',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
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
                    builder: (context) => const DoctorRegistration(
                        key: Key('doctor_registration')),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Doctor",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // ElevatedButton(
            // onPressed: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const DoctorRegistration(
            //           key: Key('doctor_registration')),
            //     ),
            //   );
            //   },
            //   child: const Text(
            //     'Doctor',
            //     style: TextStyle(
            //       color: Colors.green,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
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
                    builder: (context) => const PatientsRegistration(
                        key: Key('patients_registration')),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Patient",
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

import 'package:flutter/material.dart';
import 'package:pet_care_app/Pages/Patients/patient_login.dart';
import 'package:pet_care_app/Pages/Patients/patients_registration_page.dart';

class PetLogReg extends StatelessWidget {
  const PetLogReg({super.key});

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
                    builder: (context) => const PatientsRegistration(
                        // key: Key('doctor_registration'),
                        ),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Patient Registration",
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
                    builder: (context) => const PetLogin(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Patient Login",
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

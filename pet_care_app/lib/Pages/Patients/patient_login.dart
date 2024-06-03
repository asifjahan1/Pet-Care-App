import 'package:flutter/material.dart';
import 'package:pet_care_app/Pages/Patients/patients_registration_page.dart';
import 'package:pet_care_app/Pages/Patients/registered_patients.dart';
import 'patient_profile.dart';

class PetLogin extends StatefulWidget {
  const PetLogin({super.key});

  @override
  State<PetLogin> createState() => _PetLoginState();
}

class _PetLoginState extends State<PetLogin> {
  final TextEditingController mobileNumberController = TextEditingController();

  void _login() {
    String mobileNumber = mobileNumberController.text;

    RegistrationData? patient =
        RegisteredPatients().getPatientByMobileNumber(mobileNumber);

    if (patient != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatientProfile(data: patient),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid mobile number. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
        title: const Text(
          'Patient Login',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: mobileNumberController,
                decoration: InputDecoration(
                  hintText: 'Registered Mobile Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              Center(
                child: MaterialButton(
                  onPressed: _login,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

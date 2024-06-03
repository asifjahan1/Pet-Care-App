import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_app/Pages/Patients/patient_profile.dart';

class RegistrationData {
  String ownerName;
  String patientName;
  String address;
  int age;
  String sex;
  String mobileNumber;
  String bodyColor;
  String species;
  String date;

  RegistrationData({
    required this.ownerName,
    required this.patientName,
    required this.address,
    required this.age,
    required this.sex,
    required this.mobileNumber,
    required this.bodyColor,
    required this.species,
    required this.date,
  });
}

class PatientsRegistration extends StatefulWidget {
  const PatientsRegistration({super.key});

  @override
  State<PatientsRegistration> createState() => _PatientsRegistrationState();
}

class _PatientsRegistrationState extends State<PatientsRegistration> {
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController bodyColorController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the current date to the date text field
    dateController.text = _getCurrentDate();
  }

  String _getCurrentDate() {
    // Get the current date and format it as desired
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    return formattedDate;
  }

  void _navigateToPatientProfile() {
    // Create RegistrationData object with user inputs
    RegistrationData data = RegistrationData(
      ownerName: ownerNameController.text,
      patientName: patientNameController.text,
      address: addressController.text,
      age: int.tryParse(ageController.text) ?? 0,
      sex: sexController.text,
      mobileNumber: mobileNumberController.text,
      bodyColor: bodyColorController.text,
      species: speciesController.text,
      date: dateController.text,
    );

    // Pass the data to the profile page and navigate
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PatientProfile(data)),
    );
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
          'Patient Registration',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: ownerNameController,
                decoration: InputDecoration(
                  hintText: 'Owner Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: patientNameController,
                decoration: InputDecoration(
                  hintText: 'Patient Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  hintText: 'Age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: sexController,
                decoration: InputDecoration(
                  hintText: 'Sex',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: mobileNumberController,
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bodyColorController,
                decoration: InputDecoration(
                  hintText: 'Body Color',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: speciesController,
                decoration: InputDecoration(
                  hintText: 'Species',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: dateController,
                enabled: false, // Make the field read-only
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: MaterialButton(
                  onPressed: _navigateToPatientProfile,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text('Register Patient'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_app/Pages/Patients/patient_login.dart';
import 'package:pet_care_app/Pages/Patients/registered_patients.dart';

class PatientsRegistration extends StatefulWidget {
  const PatientsRegistration({Key? key}) : super(key: key);

  @override
  State<PatientsRegistration> createState() => _PatientsRegistrationState();
}

class _PatientsRegistrationState extends State<PatientsRegistration> {
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController bodyColorController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = _getCurrentDate();
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    return formattedDate;
  }

  void _registerPatient() {
    if (mobileNumberController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill the Mobile Number field.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    RegistrationData newPatient = RegistrationData(
      ownerName: ownerNameController.text,
      petName: patientNameController.text,
      address: addressController.text,
      age: ageController.text,
      sex: sexController.text,
      weight: weightController.text,
      mobileNumber: mobileNumberController.text,
      bodyColor: bodyColorController.text,
      species: speciesController.text,
      date: dateController.text,
    );

    RegisteredPatients().addPatient(newPatient);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PetLogin()),
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
        centerTitle: true,
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
                  hintText: 'Pet Name',
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
                  hintText: 'Age (years or months)',
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
                controller: weightController,
                decoration: InputDecoration(
                  hintText: 'Weight (KG)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: mobileNumberController,
                decoration: InputDecoration(
                  hintText: 'Mobile Number *',
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
                decoration: InputDecoration(
                  hintText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              Center(
                child: MaterialButton(
                  onPressed: _registerPatient,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text('Register Pet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationData {
  String ownerName;
  String petName;
  String address;
  String age;
  String sex;
  String weight;
  String mobileNumber;
  String bodyColor;
  String species;
  String date;

  RegistrationData({
    required this.ownerName,
    required this.petName,
    required this.address,
    required this.age,
    required this.sex,
    required this.weight,
    required this.mobileNumber,
    required this.bodyColor,
    required this.species,
    required this.date,
  });
}

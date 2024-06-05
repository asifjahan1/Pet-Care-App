// import 'package:flutter/material.dart';
// import 'package:pet_care_app/Pages/Patients/patients_registration_page.dart';

// class PatientProfile extends StatelessWidget {
//   final RegistrationData data;

//   const PatientProfile(
//       {required this.data, super.key, required RegistrationData patient});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${data.petName}\'s Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Owner Name: ${data.ownerName}'),
//             Text('Pet Name: ${data.petName}'),
//             Text('Address: ${data.address}'),
//             Text('Age: ${data.age}'),
//             Text('Sex: ${data.sex}'),
//             Text('Mobile Number: ${data.mobileNumber}'),
//             Text('Body Color: ${data.bodyColor}'),
//             Text('Species: ${data.species}'),
//             Text('Date: ${data.date}'),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
//
//
// patient_profile.dart
import 'package:flutter/material.dart';
import 'package:pet_care_app/Pages/Patients/patients_registration_page.dart';

class PatientProfile extends StatelessWidget {
  final RegistrationData data;

  const PatientProfile({super.key, required this.data});

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
          'Patient Profile',
          style: TextStyle(
            color: Colors.green,
            fontSize: 17,
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
              Row(
                children: [
                  Text('Owner Name: ${data.ownerName}'),
                  const SizedBox(width: 10),
                  Text('Patient Name: ${data.petName}'),
                ],
              ),
              const SizedBox(height: 8),
              Text('Address: ${data.address}'),
              const SizedBox(height: 8),
              Text('Age: ${data.age}'),
              const SizedBox(height: 8),
              Text('Sex: ${data.sex}'),
              const SizedBox(height: 8),
              Text('Mobile Number: ${data.mobileNumber}'),
              const SizedBox(height: 8),
              Text('Body Color: ${data.bodyColor}'),
              const SizedBox(height: 8),
              Text('Species: ${data.species}'),
              const SizedBox(height: 8),
              Text('Date: ${data.date}'),
            ],
          ),
        ),
      ),
    );
  }
}

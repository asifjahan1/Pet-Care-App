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
        title: const Text('Patient Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Owner Name: ${data.ownerName}'),
            Text('Patient Name: ${data.petName}'),
            Text('Address: ${data.address}'),
            Text('Age: ${data.age}'),
            Text('Sex: ${data.sex}'),
            Text('Mobile Number: ${data.mobileNumber}'),
            Text('Body Color: ${data.bodyColor}'),
            Text('Species: ${data.species}'),
            Text('Date: ${data.date}'),
          ],
        ),
      ),
    );
  }
}

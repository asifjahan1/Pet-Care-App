import 'package:pet_care_app/Pages/Patients/patients_registration_page.dart';

class RegisteredPatients {
  static final RegisteredPatients _instance = RegisteredPatients._internal();

  factory RegisteredPatients() {
    return _instance;
  }

  RegisteredPatients._internal();

  final List<RegistrationData> _patients = [];

  List<RegistrationData> get patients => _patients;

  void addPatient(RegistrationData patient) {
    _patients.add(patient);
  }

  RegistrationData? getPatientByMobileNumber(String mobileNumber) {
    if (_patients.isEmpty) {
      return null;
    }

    try {
      return _patients.firstWhere(
        (patient) => patient.mobileNumber == mobileNumber,
      );
    } catch (e) {
      return null;
    }
  }
}

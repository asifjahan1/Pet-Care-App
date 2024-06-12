import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _alopeciaController = TextEditingController();
  final TextEditingController _anorexiaController = TextEditingController();
  final TextEditingController _commonColdController = TextEditingController();
  final TextEditingController _constipationController = TextEditingController();
  final TextEditingController _dehydrationController = TextEditingController();
  final TextEditingController _diarrheaController = TextEditingController();
  final TextEditingController _feverController = TextEditingController();
  final TextEditingController _pneumoniaController = TextEditingController();
  final TextEditingController _vomitingController = TextEditingController();
  final TextEditingController _othersController = TextEditingController();
  final TextEditingController _dewormingController = TextEditingController();
  final TextEditingController _rabiesVaccineController =
      TextEditingController();
  final TextEditingController _fluVaccineController = TextEditingController();
  final TextEditingController _dhppDogController = TextEditingController();
  final TextEditingController _testFormController = TextEditingController();
  final TextEditingController _adviceController = TextEditingController();
  final TextEditingController _prescriptionController = TextEditingController();

  final String _date = DateFormat.yMMMMd().format(DateTime.now());
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void dispose() {
    _ownerNameController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _petNameController.dispose();
    _ageController.dispose();
    _sexController.dispose();
    _weightController.dispose();
    _alopeciaController.dispose();
    _anorexiaController.dispose();
    _commonColdController.dispose();
    _constipationController.dispose();
    _dehydrationController.dispose();
    _diarrheaController.dispose();
    _feverController.dispose();
    _pneumoniaController.dispose();
    _vomitingController.dispose();
    _othersController.dispose();
    _dewormingController.dispose();
    _rabiesVaccineController.dispose();
    _fluVaccineController.dispose();
    _dhppDogController.dispose();
    _testFormController.dispose();
    _adviceController.dispose();
    _prescriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadImage() async {
    final ByteData bytes = await rootBundle.load('images/title.jpg');
    setState(() {
      _imageData = bytes.buffer.asUint8List();
    });
  }

  bool _isValidNumber(String value) {
    if (value.isEmpty) return true;
    final number = double.tryParse(value);
    return number != null && !number.isNaN;
  }

  String _formatAge(String age) {
    final number = double.tryParse(age);
    if (number == null) return age;
    return '$age years';
  }

  String _formatWeight(String weight) {
    final number = double.tryParse(weight);
    if (number == null) return weight;
    return '$weight KG';
  }

  Future<void> _generatePDF() async {
    try {
      final pdf = pw.Document();

      final ownerName = _ownerNameController.text;
      final address = _addressController.text;
      final mobileNumber = _mobileController.text;
      final petName = _petNameController.text;
      final age = _formatAge(_ageController.text);
      final sex = _sexController.text;
      final weight = _formatWeight(_weightController.text);

      final ccForm = [
        'Alopecia: ${_alopeciaController.text}',
        'Anorexia: ${_anorexiaController.text}',
        'Common Cold: ${_commonColdController.text}',
        'Constipation: ${_constipationController.text}',
        'Dehydration: ${_dehydrationController.text}',
        'Diarrhea: ${_diarrheaController.text}',
        'Fever: ${_feverController.text}',
        'Pneumonia: ${_pneumoniaController.text}',
        'Vomiting: ${_vomitingController.text}',
        'Others: ${_othersController.text}',
      ];

      final chForm = [
        'Deworming: ${_dewormingController.text}',
        'Rabies Vaccine: ${_rabiesVaccineController.text}',
        'Flu Vaccine: ${_fluVaccineController.text}',
        'DHPPL(DOG): ${_dhppDogController.text}',
      ];

      final testForm = _testFormController.text;
      final advice = _adviceController.text;
      final prescription = _prescriptionController.text;

      // Validate numerical inputs
      if (!_isValidNumber(_ageController.text)) {
        throw Exception('Invalid number in age.');
      }
      if (!_isValidNumber(_weightController.text)) {
        throw Exception('Invalid number in weight.');
      }

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (_imageData != null)
                  pw.Center(
                    child: pw.Image(
                      pw.MemoryImage(_imageData!),
                      height: 120,
                      width: 520,
                      fit: pw.BoxFit.cover,
                    ),
                  ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text('Owner Name: $ownerName'),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Text('Address: $address'),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Text('Mobile Number: $mobileNumber'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text('Pet Name: $petName'),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Text('Age: $age'),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Text('Sex: $sex'),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Text('Weight: $weight'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text('Date: $_date'),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'C/C',
                            style: pw.TextStyle(
                                fontSize: 18, fontWeight: pw.FontWeight.bold),
                          ),
                          for (var cc in ccForm) pw.Text(cc),
                        ],
                      ),
                    ),
                    pw.VerticalDivider(
                        width: 10, thickness: 1, color: PdfColors.black),
                    pw.Expanded(
                      flex: 4,
                      child: pw.Container(
                        height: 200,
                        color: PdfColors.grey50,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(prescription),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'C/H',
                            style: pw.TextStyle(
                                fontSize: 18, fontWeight: pw.FontWeight.bold),
                          ),
                          for (var ch in chForm) pw.Text(ch),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Do not give any medicine to your pet without doctor advice. Must bring the previous prescription with you at the time of next visit. Animals eyes speak great language.',
                ),
              ],
            );
          },
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/prescription.pdf");
      await file.writeAsBytes(await pdf.save());
      await OpenFile.open(file.path);
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (_imageData != null)
                Image.memory(
                  _imageData!,
                  height: 80,
                  width: 380,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ownerNameController,
                      decoration: InputDecoration(
                        labelText: 'Owner Name',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                        labelText: 'Mobile No',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _petNameController,
                      decoration: InputDecoration(
                        labelText: 'Patient Name',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _sexController,
                      decoration: InputDecoration(
                        labelText: 'Sex',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      _date,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'C/C',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _alopeciaController,
                    decoration: InputDecoration(
                      labelText: 'Alopecia',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _alopeciaController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _anorexiaController,
                    decoration: InputDecoration(
                      labelText: 'Anorexia',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _anorexiaController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _commonColdController,
                    decoration: InputDecoration(
                      labelText: 'Common Cold',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _commonColdController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _constipationController,
                    decoration: InputDecoration(
                      labelText: 'Constipation',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _constipationController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _dehydrationController,
                    decoration: InputDecoration(
                      labelText: 'Dehydration',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _dehydrationController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _diarrheaController,
                    decoration: InputDecoration(
                      labelText: 'Diarrhea',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _diarrheaController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _feverController,
                    decoration: InputDecoration(
                      labelText: 'Fever',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _feverController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _pneumoniaController,
                    decoration: InputDecoration(
                      labelText: 'Pneumonia',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _pneumoniaController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _vomitingController,
                    decoration: InputDecoration(
                      labelText: 'Vomiting',
                      hintText: 'Symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _vomitingController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _othersController,
                    decoration: InputDecoration(
                      labelText: 'Others',
                      hintText: 'Other symptoms',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _othersController.clear();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'C/H',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _dewormingController,
                    decoration: InputDecoration(
                      labelText: 'Deworming',
                      hintText: '',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _dewormingController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _rabiesVaccineController,
                    decoration: InputDecoration(
                      labelText: 'Rabies Vaccine',
                      hintText: '',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _rabiesVaccineController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _fluVaccineController,
                    decoration: InputDecoration(
                      labelText: 'Flu Vaccine',
                      hintText: '',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _fluVaccineController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _dhppDogController,
                    decoration: InputDecoration(
                      labelText: 'DHPP(DOG)',
                      hintText: '',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _dhppDogController.clear();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 250,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _prescriptionController,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      labelText: 'Prescription Medicines',
                      border: InputBorder.none,
                      // OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(12.0),
                      //   borderSide: const BorderSide(color: Colors.grey),
                      // ),
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Do not give any medicine to your pet without doctor advice. Must bring the previous prescription with you at the time of next visit. Animals eyes speak great language.',
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.green,
                onPressed: _generatePDF,
                child: const Text(
                  'Generate PDF',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

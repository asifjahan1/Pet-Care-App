import 'package:flutter/material.dart';
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
  final TextEditingController _ccFormController = TextEditingController();
  final TextEditingController _chFormController = TextEditingController();
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
      final ccForm = _ccFormController.text;
      final chForm = _chFormController.text;
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
                pw.SizedBox(height: 20),
                pw.Divider(),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            children: [
                              pw.Expanded(child: pw.Text('C/C')),
                              pw.SizedBox(width: 10),
                              pw.Expanded(child: pw.Text(ccForm)),
                            ],
                          ),
                          pw.SizedBox(height: 10),
                          pw.Row(
                            children: [
                              pw.Expanded(child: pw.Text('C/H')),
                              pw.SizedBox(width: 10),
                              pw.Expanded(child: pw.Text(chForm)),
                            ],
                          ),
                          pw.SizedBox(height: 10),
                          pw.Row(
                            children: [
                              pw.Expanded(child: pw.Text('Test')),
                              pw.SizedBox(width: 10),
                              pw.Expanded(child: pw.Text(testForm)),
                            ],
                          ),
                          pw.SizedBox(height: 10),
                          pw.Row(
                            children: [
                              pw.Expanded(child: pw.Text('Advice')),
                              pw.SizedBox(width: 10),
                              pw.Expanded(child: pw.Text(advice)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.VerticalDivider(
                        width: 10, thickness: 1, color: PdfColors.black),
                    pw.Expanded(
                      flex: 4,
                      child: pw.Container(
                        height: 200,
                        color: PdfColors.grey200,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child: pw.Text(prescription),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),
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
                      decoration:
                          const InputDecoration(labelText: 'Owner Name'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _mobileController,
                      decoration:
                          const InputDecoration(labelText: 'Mobile Number'),
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
                      decoration: const InputDecoration(labelText: 'Pet Name'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _sexController,
                      decoration: const InputDecoration(labelText: 'Sex'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      decoration: const InputDecoration(labelText: 'Weight'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: _date,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: _ccFormController,
                          decoration: const InputDecoration(labelText: 'C/C'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _chFormController,
                          decoration: const InputDecoration(labelText: 'C/H '),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _testFormController,
                          decoration: const InputDecoration(labelText: 'Test'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _adviceController,
                          decoration:
                              const InputDecoration(labelText: 'Advice'),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                      width: 10, thickness: 1, color: Colors.black),
                  Expanded(
                    child: Container(
                      height: 500,
                      color: Colors.grey[200],
                      child: TextField(
                        controller: _prescriptionController,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          labelText: 'Prescription Medicines',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
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

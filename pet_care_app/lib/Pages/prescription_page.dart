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

  Future<void> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Prescription', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 10),
              if (_imageData != null)
                pw.Image(
                  pw.MemoryImage(_imageData!),
                  height: 100,
                  width: 100,
                ),
              pw.SizedBox(height: 20),
              pw.Text('Owner Name: ${_ownerNameController.text}'),
              pw.Text('Address: ${_addressController.text}'),
              pw.Text('Mobile Number: ${_mobileController.text}'),
              pw.SizedBox(height: 20),
              pw.Text('Pet Name: ${_petNameController.text}'),
              pw.Text('Age: ${_ageController.text}'),
              pw.Text('Sex: ${_sexController.text}'),
              pw.Text('Weight: ${_weightController.text}'),
              pw.SizedBox(height: 20),
              pw.Text('Date: $_date'),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.Text('C/C'),
              pw.Text(_ccFormController.text),
              pw.SizedBox(height: 10),
              pw.Text('C/H'),
              pw.Text(_chFormController.text),
              pw.SizedBox(height: 10),
              pw.Text('Test'),
              pw.Text(_testFormController.text),
              pw.SizedBox(height: 10),
              pw.Text('Advice'),
              pw.Text(_adviceController.text),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.Expanded(
                child: pw.Container(
                  color: PdfColors.grey200,
                  child:
                      pw.Text('Prescription medicines will be listed here...'),
                ),
              ),
              pw.Text('This is a fixed footer text that cannot be edited.'),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/prescription.pdf");
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
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
                  height: 100,
                  width: double.infinity,
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
                          decoration:
                              const InputDecoration(labelText: 'C/C Form'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _chFormController,
                          decoration:
                              const InputDecoration(labelText: 'C/H Form'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _testFormController,
                          decoration:
                              const InputDecoration(labelText: 'Test Form'),
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
                  const VerticalDivider(width: 10),
                  Expanded(
                    child: Container(
                      height: 500,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Text(
                            'Prescription medicines will be listed here...'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('This is a fixed footer text that cannot be edited.'),
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

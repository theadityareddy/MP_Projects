import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RegisterScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) updateStudentData;
  RegisterScreen({required this.updateStudentData});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  String? _resumeFileName;
  String? _resumeFilePath;

  double calculatePercentage(int obtained, int total) {
    return (obtained / total) * 100;
  }

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        _resumeFileName = result.files.single.name;
        _resumeFilePath = result.files.single.path;
        _formData['resumePath'] = _resumeFilePath;
      });
    }
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Form Submitted Successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(decoration: InputDecoration(labelText: 'Name'), validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['name'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'Email'), validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['email'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'Contact'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['contact'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'Roll No'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['rollNo'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'Graduation College'), validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['gradCollege'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'Graduation Year of Passing'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['gradYear'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'HSC College'), validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['hscCollege'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'HSC Year of Passing'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['hscYear'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'HSC Total'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['hscTotal'] = int.parse(val!)),
                TextFormField(decoration: InputDecoration(labelText: 'HSC Out Of'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['hscOutOf'] = int.parse(val!)),
                TextFormField(decoration: InputDecoration(labelText: 'SSC College'), validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['sscCollege'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'SSC Year of Passing'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['sscYear'] = val),
                TextFormField(decoration: InputDecoration(labelText: 'SSC Total'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['sscTotal'] = int.parse(val!)),
                TextFormField(decoration: InputDecoration(labelText: 'SSC Out Of'), keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null, onSaved: (val) => _formData['sscOutOf'] = int.parse(val!)),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Marks in Sem 1 (CGPA)'),
                  keyboardType: TextInputType.number,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                  onSaved: (val) => _formData['sem1'] = double.tryParse(val!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Marks in Sem 2 (CGPA)'),
                  keyboardType: TextInputType.number,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                  onSaved: (val) => _formData['sem2'] = double.tryParse(val!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Marks in Sem 3 (CGPA)'),
                  keyboardType: TextInputType.number,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                  onSaved: (val) => _formData['sem3'] = double.tryParse(val!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Marks in Sem 4 (CGPA)'),
                  keyboardType: TextInputType.number,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                  onSaved: (val) => _formData['sem4'] = double.tryParse(val!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Marks in Sem 5 (CGPA)'),
                  keyboardType: TextInputType.number,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                  onSaved: (val) => _formData['sem5'] = double.tryParse(val!),
                ),
                TextFormField(decoration: InputDecoration(labelText: 'Additional Courses'), onSaved: (val) => _formData['courses'] = val),
                ElevatedButton(
                  onPressed: _pickResume,
                  child: Text('Upload Resume (PDF)'),
                ),
                if (_resumeFileName != null) Text('Selected file: $_resumeFileName', style: TextStyle(color: Colors.green)),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _formData['hscPercentage'] = calculatePercentage(_formData['hscTotal'], _formData['hscOutOf']);
                      _formData['sscPercentage'] = calculatePercentage(_formData['sscTotal'], _formData['sscOutOf']);
                      widget.updateStudentData(_formData);
                      _showSnackbar(context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

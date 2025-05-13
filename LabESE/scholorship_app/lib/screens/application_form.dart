import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/scholarship_provider.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({super.key});

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'fullName': '',
    'dateOfBirth': '',
    'gender': '',
    'caste': '',
    'familyIncome': '',
    'address': '',
    'district': '',
    'aadharNumber': '',
    'bankAccount': '',
    'ifscCode': '',
    'institutionName': '',
    'courseName': '',
  };

  final List<String> _districts = [
    'Mumbai',
    'Pune',
    'Nagpur',
    'Thane',
    'Nashik',
    'Aurangabad',
    'Solapur',
    'Amravati',
    'Kolhapur',
    'Other'
  ];

  final List<String> _castes = [
    'Open',
    'OBC',
    'SC',
    'ST',
    'Other'
  ];

  final List<String> _courses = [
    'B-Tech CS',
    'B-Tech IT',
    'B-Tech AI/ML',
    'MCA',
    'M-Tech'
  ];

  bool _isValidAge(DateTime date) {
    final age = DateTime.now().difference(date).inDays ~/ 365;
    return age >= 14;
  }

  bool _isValidIFSC(String ifsc) {
    final ifscRegex = RegExp(r'^[A-Z]{3}[0-9]{4}$');
    return ifscRegex.hasMatch(ifsc);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 14)),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6C63FF),
              onPrimary: Colors.white,
              surface: Color(0xFF2D2D2D),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (_isValidAge(picked)) {
        setState(() {
          _formData['dateOfBirth'] = DateFormat('dd/MM/yyyy').format(picked);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Age must be at least 14 years'),
            backgroundColor: Color(0xFFE53935),
          ),
        );
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<ScholarshipProvider>(context, listen: false)
          .submitApplication(_formData);
      Navigator.pushReplacementNamed(context, '/status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scholarship Application'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (value.length > 26) {
                    return 'Name should not exceed 26 characters';
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Name should contain only letters and spaces';
                  }
                  return null;
                },
                onSaved: (value) => _formData['fullName'] = value!,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _formData['dateOfBirth'] ?? 'Select Date',
                    style: TextStyle(
                      color: _formData['dateOfBirth'] == null ? Colors.white70 : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                dropdownColor: const Color(0xFF2D2D2D),
                style: const TextStyle(color: Colors.white),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
                onChanged: (value) => _formData['gender'] = value!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Caste',
                  border: OutlineInputBorder(),
                ),
                dropdownColor: const Color(0xFF2D2D2D),
                style: const TextStyle(color: Colors.white),
                items: _castes
                    .map((caste) => DropdownMenuItem(
                          value: caste,
                          child: Text(caste),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your caste';
                  }
                  return null;
                },
                onChanged: (value) => _formData['caste'] = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Annual Family Income (in ₹)',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your family income';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Income should contain only numbers';
                  }
                  return null;
                },
                onSaved: (value) => _formData['familyIncome'] = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
                    return 'Address should contain only letters, numbers, and basic punctuation';
                  }
                  return null;
                },
                onSaved: (value) => _formData['address'] = value!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'District',
                  border: OutlineInputBorder(),
                ),
                dropdownColor: const Color(0xFF2D2D2D),
                style: const TextStyle(color: Colors.white),
                items: _districts
                    .map((district) => DropdownMenuItem(
                          value: district,
                          child: Text(district),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your district';
                  }
                  return null;
                },
                onChanged: (value) => _formData['district'] = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Aadhar Number',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Aadhar number';
                  }
                  if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                    return 'Aadhar number must be 12 digits';
                  }
                  return null;
                },
                onSaved: (value) => _formData['aadharNumber'] = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Bank Account Number',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bank account number';
                  }
                  if (!RegExp(r'^\d{9,18}$').hasMatch(value)) {
                    return 'Bank account number must be between 9 and 18 digits';
                  }
                  return null;
                },
                onSaved: (value) => _formData['bankAccount'] = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'IFSC Code',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your IFSC code';
                  }
                  if (!_isValidIFSC(value)) {
                    return 'IFSC code must be 7 characters (3 letters + 4 numbers)';
                  }
                  return null;
                },
                onSaved: (value) => _formData['ifscCode'] = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Institution Name',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your institution name';
                  }
                  return null;
                },
                onSaved: (value) => _formData['institutionName'] = value!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                ),
                dropdownColor: const Color(0xFF2D2D2D),
                style: const TextStyle(color: Colors.white),
                items: _courses
                    .map((course) => DropdownMenuItem(
                          value: course,
                          child: Text(course),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your course';
                  }
                  return null;
                },
                onChanged: (value) => _formData['courseName'] = value!,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  'Submit Application',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
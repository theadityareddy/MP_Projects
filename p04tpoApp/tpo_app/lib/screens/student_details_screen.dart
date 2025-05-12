import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> studentData;
  StudentDetailsScreen({required this.studentData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Name: ${studentData['name'] ?? "N/A"}'),
              Text('Email: ${studentData['email'] ?? "N/A"}'),
              Text('Contact: ${studentData['contact'] ?? "N/A"}'),
              Text('Roll No: ${studentData['rollNo'] ?? "N/A"}'),
              Text('HSC Percentage: ${studentData['hscPercentage']?.toStringAsFixed(2) ?? "N/A"}%'),
              Text('SSC Percentage: ${studentData['sscPercentage']?.toStringAsFixed(2) ?? "N/A"}%'),
              Text('Marks in Sem 1: ${studentData['sem1'] ?? "N/A"} CGPA'),
              Text('Marks in Sem 2: ${studentData['sem2'] ?? "N/A"} CGPA'),
              Text('Marks in Sem 3: ${studentData['sem3'] ?? "N/A"} CGPA'),
              Text('Marks in Sem 4: ${studentData['sem4'] ?? "N/A"} CGPA'),
              Text('Marks in Sem 5: ${studentData['sem5'] ?? "N/A"} CGPA'),
              Text('Additional Courses: ${studentData['courses'] ?? "N/A"}'),
            ],
          ),
        ),
      ),
    );
  }
}

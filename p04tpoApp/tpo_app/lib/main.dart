import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
import 'screens/view_resume_screen.dart';
import 'screens/company_details_screen.dart';
import 'screens/student_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> studentData = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPO App',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: MyHomePage(
        updateStudentData: (data) {
          setState(() {
            studentData = data;
          });
        },
        studentData: studentData,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(Map<String, dynamic>) updateStudentData;
  final Map<String, dynamic> studentData;

  MyHomePage({required this.updateStudentData, required this.studentData});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      RegisterScreen(updateStudentData: widget.updateStudentData),
      ViewResumeScreen(resumeFilePath: widget.studentData['resumePath']),
      CompanyDetailsScreen(),
      StudentDetailsScreen(studentData: widget.studentData),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/LogoSPIT.png', height: 50),
            SizedBox(width: 10),
            Text('SPIT - TPO App'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              // decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/LogoSPIT.png', height: 120),
                  SizedBox(height: 10),
                  // Text('SPIT', style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              title: Text('Register'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            ListTile(
              title: Text('View Resume'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 1);
              },
            ),
            ListTile(
              title: Text('Company Details'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 2);
              },
            ),
            ListTile(
              title: Text('Student Details'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 3);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

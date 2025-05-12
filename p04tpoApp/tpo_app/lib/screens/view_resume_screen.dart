import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class ViewResumeScreen extends StatelessWidget {
  final String? resumeFilePath;
  ViewResumeScreen({this.resumeFilePath});

  void _openResume() {
    if (resumeFilePath != null) {
      OpenFile.open(resumeFilePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Resume')),
      body: Center(
        child: resumeFilePath != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Resume Uploaded', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openResume,
              child: Text('Open Resume'),
            ),
          ],
        )
            : Text('No Resume Uploaded', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}

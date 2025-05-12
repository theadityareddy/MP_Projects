import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 140,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/profile.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                'Kshitij Mahale',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
            ),
            SizedBox(height: 8),
            _buildSectionTitle('About Me'),
            Text(
              'Driven to create seamless web and mobile applications focused on the user experience.',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            _buildSectionTitle('Skills'),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                _buildSkillItem('PHP'),
                _buildSkillItem('MySQL'),
                _buildSkillItem('Java'),
                _buildSkillItem('MERN'),
              ],
            ),
            SizedBox(height: 24),
            _buildSectionTitle('Education'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Master in Computer Application',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Sardar Patel Institute of Technology, Mumbai',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                SizedBox(height: 8),
                Text(
                  'Bachelor in Computer Application',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'B.Y.K College of Commerce, Nashik',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
            SizedBox(height: 24),
            _buildSectionTitle('Contact'),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.email, color: Colors.teal),
                    SizedBox(width: 8),
                    Text('kshitij.mahale02@spit.ac.in', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.link, color: Colors.teal),
                    SizedBox(width: 8),
                    Text('linkedin.com/in/kshitij-mahale-6555ba221/', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.message, color: Colors.teal),
                    SizedBox(width: 8),
                    Text('twitter.com/kshitij423', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: Text(
                '© 2025 Kshitij Mahale',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildSkillItem(String skill) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '• ',
          style: TextStyle(fontSize: 16, color: Colors.teal),
        ),
        Text(
          skill,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

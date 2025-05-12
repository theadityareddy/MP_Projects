import 'package:flutter/material.dart';

class CompanyDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: Text('Company Name: PhonePe'),
            subtitle: Text('''
Location: Bangalore
Salary Range: ₹15,00,000 - ₹40,00,000 (Placement)
Profile: Technology and Software Development'''),
          ),
          ListTile(
            title: Text('Company Name: Microsoft'),
            subtitle: Text('''
Location: Hyderabad
Salary Range: ₹14,00,000 - ₹35,00,000 (Placement)
Profile: Software Development, Cloud Computing, AI, and Enterprise Solutions'''),
          ),
          ListTile(
            title: Text('Company Name: Amazon'),
            subtitle: Text('''
Location: Chennai
Salary Range: ₹12,00,000 - ₹30,00,000 (Placement)
Profile: E-Commerce, Cloud Services, AI, and Logistics'''),
          ),
          ListTile(
            title: Text('Company Name: Infosys'),
            subtitle: Text('''
Location: Pune
Salary Range: ₹20,000 - ₹50,000 (Internship)
Profile: IT Consulting, Software Development, and AI Solutions'''),
          ),
          ListTile(
            title: Text('Company Name: Deloitte'),
            subtitle: Text('''
Location: Gurugram
Salary Range: ₹6,00,000 - ₹15,00,000 (Placement)
Profile: Consulting, Finance, IT Solutions, and Business Services'''),
          ),
        ],
      ),
    );
  }
}

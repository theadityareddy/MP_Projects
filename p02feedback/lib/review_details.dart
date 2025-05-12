import 'package:flutter/material.dart';

class ReviewDetails extends StatelessWidget {
  final String name;
  final String surname;
  final String dob;
  final String address;
  final String email;
  final String phone;
  final String gender;
  final String review;
  final int rating;

  const ReviewDetails({
    Key? key,
    required this.name,
    required this.surname,
    required this.dob,
    required this.address,
    required this.email,
    required this.phone,
    required this.gender,
    required this.review,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Details'),
        backgroundColor: Colors.amber[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(color: Colors.grey, width: 1),
          columnWidths: const {
            0: FractionColumnWidth(0.35),
            1: FractionColumnWidth(0.65),
          },
          children: [
            _buildRow('Name', name),
            _buildRow('Surname', surname),
            _buildRow('Date of Birth', dob),
            _buildRow('Address', address),
            _buildRow('Email ID', email),
            _buildRow('Phone no.', phone),
            _buildRow('Gender', gender),
            if (review.isNotEmpty) _buildRow('Review', review),
            _buildRow('Rating', '$rating Stars'),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(String label, String value) {
    return TableRow(
      children: [
        _buildTableCell(label),
        _buildTableCell(value),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
    );
  }
}

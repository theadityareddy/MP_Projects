import 'package:flutter/material.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFaculty;
  int _rating = 0;

  final List<String> _facultyNames = [
    "Prof. Dr. Dhananjay Kalbande",
    "Prof. Dr. Pooja Raundale",
    "Prof. Dr. Aarti Karande",
    "Prof. Harshil Kanakia",
    "Prof. Nikhita Mangaonkar",
    "Prof. Sakina Shaikh",
    "Prof. Pallavi Thakur"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Faculty",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              value: _selectedFaculty,
              items: _facultyNames
                  .map((faculty) => DropdownMenuItem<String>(
                value: faculty,
                child: Text(faculty),
              ))
                  .toList(),
              onChanged: (value) => _selectedFaculty = value,
              validator: (value) => value == null || value.isEmpty
                  ? "Please select a faculty member"
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Subject",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              validator: (value) => value == null || value.isEmpty
                  ? "Please enter the subject"
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Feedback",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              maxLines: 5,
              validator: (value) => value == null || value.isEmpty
                  ? "Please enter your feedback"
                  : null,
            ),
            const SizedBox(height: 16),
            const Text("Rating:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Feedback submitted successfully!")),
                  );
                  _formKey.currentState!.reset();
                  _selectedFaculty = null;
                  _rating = 0;
                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[700], // Updated button color
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Submit",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
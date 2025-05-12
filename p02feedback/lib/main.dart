// main.dart
import 'package:flutter/material.dart';
import 'review_form.dart';

void main() {
  runApp(const MovieReviewApp());
}

class MovieReviewApp extends StatelessWidget {
  const MovieReviewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ReviewForm(),
    );
  }
}

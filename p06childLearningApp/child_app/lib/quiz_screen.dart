import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Map<String, dynamic>> quizData;
  int currentQuestionIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    quizData = _generateQuizData();
    _shuffleQuizData();
  }

  static String _numberToWord(int number) {
    const List<String> words = [
      'One', 'Two', 'Three', 'Four', 'Five',
      'Six', 'Seven', 'Eight', 'Nine', 'Ten',
      'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen',
      'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen', 'Twenty'
    ];
    return words[number - 1];
  }

  List<Map<String, dynamic>> _generateQuizData() {
    return [
      {
        'type': 'alphabet',
        'question': 'Which letter comes after A?',
        'display': 'A',
        'options': ['B', 'C', 'D'],
        'answer': 'B',
      },
      {
        'type': 'alphabet',
        'question': 'Which one is a vowel?',
        'display': 'Letters: A, B, C',
        'options': ['A', 'B', 'C'],
        'answer': 'A',
      },
      {
        'type': 'number',
        'question': 'What number is this?',
        'display': '3',
        'options': ['3', 'A', '!'],
        'answer': '3',
      },
      {
        'type': 'number',
        'question': 'Which number comes after 7?',
        'display': '7',
        'options': ['6', '8', '10'],
        'answer': '8',
      },
      {
        'type': 'math',
        'question': 'What is 2 + 2?',
        'display': '?',
        'options': ['4', '3', '5'],
        'answer': '4',
      },
      {
        'type': 'math',
        'question': 'How many sides does a triangle have?',
        'display': '▲',
        'options': ['3', '4', '5'],
        'answer': '3',
      },
      {
        'type': 'logic',
        'question': 'What color is the sky on a clear day?',
        'display': '🌤️',
        'options': ['Blue', 'Green', 'Yellow'],
        'answer': 'Blue',
      },
      {
        'type': 'logic',
        'question': 'Which one can fly?',
        'display': '🐦 🐶 🐘',
        'options': ['Bird', 'Dog', 'Elephant'],
        'answer': 'Bird',
      },
      {
        'type': 'alphabet',
        'question': 'What is the first letter of “Apple”?',
        'display': '🍎 Apple',
        'options': ['A', 'P', 'L'],
        'answer': 'A',
      },
      {
        'type': 'number',
        'question': 'How many fingers do you have on one hand?',
        'display': '✋',
        'options': ['4', '5', '6'],
        'answer': '5',
      },
    ];
  }


  void _shuffleQuizData() {
    quizData.shuffle(Random());
    for (var question in quizData) {
      question['options'].shuffle(Random());
    }
  }

  void checkAnswer(String selectedOption) async {
    bool isCorrect = selectedOption == quizData[currentQuestionIndex]['answer'];
    if (isCorrect) score++;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? "Correct!" : "Wrong!"),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: const Duration(milliseconds: 300),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      if (currentQuestionIndex < 9) {
        currentQuestionIndex++;
      } else {
        _saveScore();
        _showResultDialog();
      }
    });
  }

  void _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('userName') ?? 'Saumya';
    await prefs.setInt('latestScore_$name', score);
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("🎉 Quiz Completed!"),
        content: Text("Your score: $score/10"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestionIndex = 0;
                score = 0;
                _shuffleQuizData();
              });
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizData[currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / 10,
            color: Colors.lightBlueAccent,
            backgroundColor: Colors.grey[300],
            minHeight: 8,
          ),
          const SizedBox(height: 20),
          Text(
            "Question ${currentQuestionIndex + 1}/10",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            currentQuestion['question'],
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "What is this?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: currentQuestion['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

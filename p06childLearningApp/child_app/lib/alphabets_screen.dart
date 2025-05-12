import 'package:flutter/material.dart';
import 'dart:math';

class AlphabetsScreen extends StatelessWidget {
  final List<Map<String, String>> alphabets = List.generate(
    26,
        (index) => {
      'upper': String.fromCharCode(65 + index),
      'lower': String.fromCharCode(97 + index),
    },
  );

  AlphabetsScreen({super.key});

  final List<List<Color>> gradientColors = [
    [Color(0xFF89F7FE), Color(0xFF66A6FF)],
    [Color(0xFFFFD3A5), Color(0xFFFFA6B7)],
    [Color(0xFFA1FFCE), Color(0xFFFAFFD1)],
    [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
    [Color(0xFFF6D365), Color(0xFFFDA085)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1,
        ),
        itemCount: alphabets.length,
        itemBuilder: (context, index) {
          final gradient = gradientColors[index % gradientColors.length];

          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "You tapped: ${alphabets[index]['upper']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  duration: const Duration(milliseconds: 800),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.95, end: 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            alphabets[index]['upper']!,
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            alphabets[index]['lower']!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

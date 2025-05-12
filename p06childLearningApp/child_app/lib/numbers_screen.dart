import 'package:flutter/material.dart';

class NumbersScreen extends StatelessWidget {
  final List<Map<String, String>> numbers = List.generate(
    20,
        (index) => {
      'number': (index + 1).toString(),
      'text': _numberToWord(index + 1),
    },
  );

  NumbersScreen({super.key});

  static String _numberToWord(int number) {
    const List<String> words = [
      'One', 'Two', 'Three', 'Four', 'Five',
      'Six', 'Seven', 'Eight', 'Nine', 'Ten',
      'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen',
      'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen', 'Twenty',
    ];
    return words[number - 1];
  }

  final List<List<Color>> gradientColors = [
    [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
    [Color(0xFFB5FFFC), Color(0xFF91EAE4)],
    [Color(0xFFB3FFAB), Color(0xFF12FFF7)],
    [Color(0xFFF6D365), Color(0xFFFDA085)],
    [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          final gradient = gradientColors[index % gradientColors.length];

          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "You tapped: ${numbers[index]['text']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  duration: const Duration(milliseconds: 800),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.95, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
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
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            numbers[index]['number']!,
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            numbers[index]['text']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
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

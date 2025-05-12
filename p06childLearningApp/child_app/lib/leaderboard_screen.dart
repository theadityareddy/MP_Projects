import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> leaderboardData = [
    {'name': 'Kshitij', 'score': 0},
    {'name': 'Aarav', 'score': 8},
    {'name': 'Ishita', 'score': 6},
    {'name': 'Rohan', 'score': 9},
    {'name': 'Diya', 'score': 7},
    {'name': 'Vivaan', 'score': 5},
    {'name': 'Tanvi', 'score': 4},
  ];

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('userName') ?? 'Kshitij';
    int score = prefs.getInt('latestScore_$name') ?? 0;

    setState(() {
      leaderboardData[0] = {'name': name, 'score': score};
      leaderboardData.sort((a, b) => b['score'].compareTo(a['score']));
    });
  }

  Color _getTileColor(int index) {
    if (index == 0) return Colors.orangeAccent.shade100;
    if (index == 1) return Colors.amber.shade100;
    if (index == 2) return Colors.deepOrange.shade100;
    return Colors.teal.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: leaderboardData.length,
      itemBuilder: (context, index) {
        final player = leaderboardData[index];
        final isTopScorer = index == 0;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: _getTileColor(index),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                player['name'][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              player['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: index < 3
                ? Text(
              index == 0
                  ? '🏆 Top Scorer'
                  : index == 1
                  ? '🥈 2nd Place'
                  : '🥉 3rd Place',
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal[700],
                fontWeight: FontWeight.w500,
              ),
            )
                : null,
            trailing: Text(
              "Score: ${player['score']}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}

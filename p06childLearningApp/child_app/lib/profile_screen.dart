import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Kshitij';
  int stars = 0;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Kshitij';
      stars = (prefs.getInt('latestScore_$userName') ?? 0) ~/ 2;
      _nameController.text = userName;
    });
  }

  Future<void> _saveName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    int oldScore = prefs.getInt('latestScore_$userName') ?? 0;
    await prefs.setString('userName', newName);
    await prefs.setInt('latestScore_$newName', oldScore);
    setState(() {
      userName = newName;
      stars = oldScore ~/ 2;
    });
    Navigator.pop(context);
  }

  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: "Enter your name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () => _saveName(_nameController.text.trim()),
            child: const Text("Save", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.lightBlueAccent,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _showEditNameDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black12,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text("Edit Name", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

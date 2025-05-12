import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool notificationsEnabled = true;
  String selectedLanguage = 'English';

  final List<String> languages = ['English', 'Hindi', 'Marathi', 'Tamil'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          const SizedBox(height: 16),

          const Text('Aditya Reddy', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('aditya.reddy24@spit.ac.in'),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Edit Profile'),
          ),

          const SizedBox(height: 24),

          const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () {
            },
            child: const Text('Change your password'),
          ),
          const SizedBox(height: 16),

          const Text('Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
              ),

              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                trailing: DropdownButton<String>(
                  value: selectedLanguage,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                    });
                  },
                  items: languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

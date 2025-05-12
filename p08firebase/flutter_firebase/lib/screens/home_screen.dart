import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth_provider.dart';
import 'create_screen.dart';
import 'read_screen.dart';
import 'update_screen.dart';
import 'delete_screen.dart';
import 'auth_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    CreateScreen(),
    ReadScreen(),
    UpdateScreen(),
    DeleteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S.P.I.T. Banking App'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Read'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Update'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete'),
        ],
      ),
    );
  }
}

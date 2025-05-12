import 'package:flutter/material.dart';
import 'welcome.dart';
import 'faculty.dart';
import 'vissionmission.dart';
import 'feedback.dart';
import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MCA Department',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blue[700],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.group), text: 'Faculties'),
            Tab(icon: Icon(Icons.featured_play_list), text: 'Vision & Mission'),
            Tab(icon: Icon(Icons.notifications), text: 'Notifications'),
            Tab(icon: Icon(Icons.feedback), text: 'Feedback'),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: TabBarView(
        controller: _tabController,
        children: const [
          WelcomePage(),
          FacultyPage(),
          VissionMissionPage(),
          NotificationPage(),
          FeedBackPage(),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[700],
            ),
            child: const Text(
              'Master of Computer Application',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue[700]),
            title: const Text('Home', style: TextStyle(fontSize: 16)),
            onTap: () {
              _tabController.index = 0;
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.group, color: Colors.blue[700]),
            title: const Text('Faculties', style: TextStyle(fontSize: 16)),
            onTap: () {
              _tabController.index = 1;
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.featured_play_list, color: Colors.blue[700]),
            title: const Text('Vision & Mission', style: TextStyle(fontSize: 16)),
            onTap: () {
              _tabController.index = 2;
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue[700]),
            title: const Text('Notifications', style: TextStyle(fontSize: 16)),
            onTap: () {
              _tabController.index = 3;
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.blue[700]),
            title: const Text('Feedback', style: TextStyle(fontSize: 16)),
            onTap: () {
              _tabController.index = 4;
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
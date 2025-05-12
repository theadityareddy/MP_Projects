import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/auth_provider.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';

class DeleteScreen extends StatefulWidget {
  @override
  _DeleteScreenState createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final DatabaseService _databaseService = DatabaseService();
  bool _isLoading = false;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId =
          Provider.of<AuthProvider>(context, listen: false).user!.uid;
      final user = await _databaseService.getUser(userId);

      setState(() {
        _user = user;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading user data: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _deleteUser() async {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Confirm Deletion'),
            content: Text(
              'Are you sure you want to delete your user data? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();

                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    final userId =
                        Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        ).user!.uid;
                    await _databaseService.deleteUser(userId);

                    setState(() {
                      _user = null;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User deleted successfully!')),
                    );
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error deleting user: ${error.toString()}',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_user == null) {
      return Center(child: Text('No user data found. Create a user first.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Information',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Full Name'),
                    subtitle: Text(_user!.fullName),
                    leading: Icon(Icons.person),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Email'),
                    subtitle: Text(_user!.email),
                    leading: Icon(Icons.email),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Phone Number'),
                    subtitle: Text(_user!.phoneNumber),
                    leading: Icon(Icons.phone),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Date of Birth'),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(_user!.dateOfBirth),
                    ),
                    leading: Icon(Icons.calendar_today),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Address'),
                    subtitle: Text(_user!.address),
                    leading: Icon(Icons.home),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Account Type'),
                    subtitle: Text(_user!.accountType),
                    leading: Icon(Icons.account_balance),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: _deleteUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Delete User Data',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

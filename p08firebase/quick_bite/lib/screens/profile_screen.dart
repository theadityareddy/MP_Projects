import 'package:flutter/material.dart';
import 'package:quick_bite/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Implement edit profile functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppTheme.surfaceColor,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: AppTheme.onSurfaceColor,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: AppTheme.onPrimaryColor,
                          size: 20,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'John Doe',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'john.doe@example.com',
              style: GoogleFonts.poppins(
                color: AppTheme.onSurfaceColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileSection(
              title: 'Account Settings',
              items: [
                _buildProfileItem(
                  icon: Icons.person_outline,
                  title: 'Personal Information',
                  onTap: () {},
                ),
                _buildProfileItem(
                  icon: Icons.location_on_outlined,
                  title: 'Delivery Addresses',
                  onTap: () {},
                ),
                _buildProfileItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildProfileSection(
              title: 'Preferences',
              items: [
                _buildProfileItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {},
                ),
                _buildProfileItem(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  onTap: () {},
                ),
                _buildProfileItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildProfileSection(
              title: 'Support',
              items: [
                _buildProfileItem(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {},
                ),
                _buildProfileItem(
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  onTap: () {},
                ),
                _buildProfileItem(
                  icon: Icons.logout_outlined,
                  title: 'Logout',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppTheme.onSurfaceColor,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppTheme.onSurfaceColor,
      ),
      onTap: onTap,
    );
  }
} 
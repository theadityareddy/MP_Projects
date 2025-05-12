import 'package:flutter/material.dart';
import 'package:quick_bite/screens/home_screen.dart';
import 'package:quick_bite/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.restaurant,
                size: 60,
                color: AppTheme.onPrimaryColor,
              ),
            )
                .animate()
                .scale(duration: const Duration(milliseconds: 500))
                .then()
                .shake(duration: const Duration(milliseconds: 500)),
            const SizedBox(height: 24),
            Text(
              'Quick Bite',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.onBackgroundColor,
              ),
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 500))
                .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 16),
            Text(
              'Your Favorite Food Delivery App',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppTheme.onBackgroundColor.withOpacity(0.7),
              ),
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 500))
                .slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }
} 
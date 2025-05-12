import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/auth_screen.dart';
import 'package:flutter_firebase/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'models/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => AuthProvider())],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'SecureBank',
          theme: ThemeData(
            brightness: Brightness.dark,
            // 60% - Primary Background Color
            scaffoldBackgroundColor: const Color(0xFF1E1E2E),
            // 30% - Secondary Color (Cards, Surfaces)
            primaryColor: const Color(0xFF2D2D44),
            // 10% - Accent Color
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6C63FF), // Accent color for primary actions
              secondary: Color(0xFF00D9F5), // Secondary accent for highlights
              surface: Color(0xFF2D2D44), // 30% - Card backgrounds
              background: Color(0xFF1E1E2E), // 60% - Main background
              error: Color(0xFFFF6B6B),
            ),
            cardTheme: CardTheme(
              color: const Color(0xFF2D2D44),
              elevation: 8,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF2D2D44),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
              ),
              labelStyle: const TextStyle(
                color: Color(0xFF8A8A8A),
                fontSize: 16,
              ),
              hintStyle: const TextStyle(
                color: Color(0xFF8A8A8A),
                fontSize: 16,
              ),
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
              headlineMedium: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
              bodyLarge: TextStyle(
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
              bodyMedium: TextStyle(
                fontSize: 14,
                color: Color(0xFF8A8A8A),
                letterSpacing: 0.3,
              ),
            ),
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}

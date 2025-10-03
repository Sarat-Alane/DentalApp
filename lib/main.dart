import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen file

void main() {
  runApp(const DentalCavityApp());
}

class DentalCavityApp extends StatelessWidget {
  const DentalCavityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental Cavity Detection',
      theme: ThemeData(
        // Define a clean and professional color scheme
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter', // A nice, clean font

        // Define the visual density for a modern look
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Custom theme for elevated buttons for a consistent look
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue.shade600, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      // The first screen of the app is the splash screen
      home: const SplashScreen(),
    );
  }
}

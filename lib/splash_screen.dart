import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the login page

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after a 3-second delay
    Timer(
      const Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your app's logo
            Image.asset(
              'assets/images/dental.png', // The path to your image
              width: 100, // You can control the size with width and height
              height: 100,
            ),
            const SizedBox(height: 24),
            // Your app's name
            const Text(
              'Cavity Detector',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xff1565C0),
              ),
            ),
            const SizedBox(height: 80),
            // A loading indicator
            CircularProgressIndicator(
              color: Colors.blue.shade600,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds before navigating
    Timer(const Duration(seconds: 3), () {
      // Navigate to onboarding screen after 3 seconds
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // White background
      body: Center(
        child: Image(
          image: AssetImage('assets/logo.png'), // your logo path
          width: 180,
        ),
      ),
    );
  }
}

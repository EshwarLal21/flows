import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingTemplate extends StatelessWidget {
  final String title;
  final String highlight;
  final String subtitle;
  final String imagePath;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool showBack;

  const OnboardingTemplate({
    super.key,
    required this.title,
    required this.highlight,
    required this.subtitle,
    required this.imagePath,
    required this.onNext,
    this.onBack,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', height: 40),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('skip', style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Text
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: const Color(0xFF0A1931),
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(text: '$title '),
                    TextSpan(
                      text: highlight,
                      style: const TextStyle(
                        color: Color(0xFF185ADB),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),

              // Image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
                ),
              ),

              const SizedBox(height: 30),

              // Controls
              // Replace your Row with this
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showBack)
                    IconButton(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: Colors.white,
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFF8BC83F),
                      ),
                    ),
                  const SizedBox(width: 16),
                  // Optional: show dots indicator
                  Row(
                    children: List.generate(
                      3, // number of onboarding pages
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

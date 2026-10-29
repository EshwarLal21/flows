import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/house1.png',
      'title': 'Discover Properties\nTailored To Your Needs',
      'subtitle':
      'Easily browse, compare, and secure your next property. From cozy homes to spacious villas, find it all here.',
    },
    {
      'image': 'assets/house2.png',
      'title': 'Find Your Perfect\nHome Effortlessly',
      'subtitle':
      'Explore listings, view detailed photos, and connect with trusted agents right within the app.',
    },
    {
      'image': 'assets/house3.png',
      'title': 'Your Dream Space\nAwaits You',
      'subtitle':
      'Join CozyNest today and start your journey to finding the home that fits your lifestyle.',
    },
  ];

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for swiping
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Image.asset(
                    data['image']!,
                    fit: BoxFit.cover,
                  ),

                  // Dark overlay
                  Container(
                    color: Colors.black.withOpacity(0.4),
                  ),

                  // Content
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 🔹 App Logo (white)
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/logo.png', // make sure you have white logo asset
                            height: 50,
                            color: Colors.white, // ensures white tint if not pure white
                          ),
                        ),

                        // 🔹 Move text section toward bottom (above buttons)
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              data['title']!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              data['subtitle']!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // 🔹 Dots indicator
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                onboardingData.length,
                                    (dotIndex) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  width: currentIndex == dotIndex ? 18 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: currentIndex == dotIndex
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // 🔹 Bottom Buttons (less height, more width)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Join Button
                            ElevatedButton(
                              onPressed: () {
                                if (currentIndex ==
                                    onboardingData.length - 1) {
                                  Navigator.pushReplacementNamed(
                                      context, '/register');
                                } else {
                                  nextPage();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                currentIndex == onboardingData.length - 1
                                    ? "Join"
                                    : "Next",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Sign In Button
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

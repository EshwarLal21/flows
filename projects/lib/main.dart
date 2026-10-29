import 'package:flutter/material.dart';
import 'package:projects/view/application/application_screen.dart';
import 'package:projects/view/application/emplyment_history.dart';
import 'package:projects/view/application/inspection_page.dart';
import 'package:projects/view/application/occupation_screen.dart';
import 'package:projects/view/application/property_lease_form.dart';
import 'package:projects/view/authScreens/login_screen.dart' hide EditOccupantScreen;
import 'package:projects/view/authScreens/otp_screen.dart';
import 'package:projects/view/authScreens/sign_up_screen.dart';
import 'package:projects/view/homeScreens/home_screen.dart';
import 'package:projects/view/my_profile/my__profile_screen.dart';
import 'package:projects/view/onboardingScreens/onboarding_screen1.dart';
import 'package:projects/view/splahScreen/splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes: {
          '/': (context) =>  SplashScreen(),
       // '/': (context) => const AddEmploymentHistoryScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),

        // 🔹 Authentication routes
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/otp': (context) => const OTPScreen(email: ''),
        '/application':(context) => PropertyDetailScreen(),
        '/inspections':(context) => InspectionScreen(),
        '/propertyleaseform':(context)=> MultiStepLeaseForm(),
        '/profile':(context)=> BusinessProfileScreen()
        // email can be passed dynamically
      },
    );
  }
}

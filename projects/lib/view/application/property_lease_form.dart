import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'application_forms/PetsScreen.dart';
import 'application_forms/connection_services_screen.dart';
import 'application_forms/occupant.dart';
import 'application_forms/profile_step.dart';
import 'application_forms/property_information_step.dart';
import 'application_forms/submit_screen.dart';
import 'application_forms/terms_condition_screen.dart';
import 'application_forms/vehicle_screen.dart';

class MultiStepLeaseForm extends StatefulWidget {
  const MultiStepLeaseForm({super.key});

  @override
  State<MultiStepLeaseForm> createState() => _MultiStepLeaseFormState();
}

class _MultiStepLeaseFormState extends State<MultiStepLeaseForm> {
  int currentStep = 0;
  final int totalSteps = 8;

  final Color primary500 = const Color(0xFF6C2EC8);
  final Color primary600 = const Color(0xFF5823B0);
  final Color primary700 = const Color(0xFF431A8F);

  final addressController = TextEditingController();

  List<Widget> get steps => [
    PropertyInformationStep(addressController: addressController),
    EditOccupantScreen(),
    ApplicantProfileScreen(),
    PetsScreen(),
    VehicleScreen(),
    ConnectionServicesScreen(),
    TermsConditionsScreen(),
    SignAndSubmitScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primary600,
        centerTitle: true,
        title: Text(
          "Lease Application",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: isSmall ? 20 : 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 8 : 16,
            vertical: 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildStepIndicator(isSmall, size.width),
              const SizedBox(height: 20),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(anim),
                      child: child,
                    ),
                  ),
                  child: steps[currentStep],
                ),
              ),
              const SizedBox(height: 15),
              buildNavigationButtons(isSmall),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Full-width Step Indicator (auto-fit to screen)
  Widget buildStepIndicator(bool isSmall, double screenWidth) {
    final stepTitles = [
      "Lease",
      "Job",
      "Profile",
      "Pets",
      "Vehicle",
      "Connect",
      "Terms",
      "Submit"
    ];

    // Auto-adjust circle & line sizes
    double circleSize = isSmall ? 26 : 30;
    double lineWidth = (screenWidth - (circleSize * totalSteps)) / (totalSteps - 1);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(totalSteps, (index) {
            bool isActive = currentStep == index;
            bool isCompleted = currentStep > index;

            return Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      // Circle
                      Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          color: isActive || isCompleted ? primary500 : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isActive || isCompleted
                                ? primary500
                                : Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: GoogleFonts.poppins(
                              fontSize: isSmall ? 11 : 13,
                              color: isActive || isCompleted
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      // Connector line except for last circle
                      if (index != totalSteps - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isCompleted ? primary500 : Colors.grey.shade300,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stepTitles[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isSmall ? 9 : 10.5,
                      color: isActive ? primary500 : Colors.grey.shade700,
                      fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // 🔹 Navigation Buttons
  Widget buildNavigationButtons(bool isSmall) {
    bool isLastStep = currentStep == totalSteps - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentStep > 0)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => setState(() => currentStep--),
              icon: const Icon(Icons.arrow_back_ios_new, size: 16),
              label: Text(
                "Back",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: isSmall ? 13 : 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primary600,
                padding: EdgeInsets.symmetric(
                    horizontal: isSmall ? 8 : 20, vertical: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: primary600, width: 1.2),
                ),
              ),
            ),
          )
        else
          const SizedBox(width: 100),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              if (!isLastStep) {
                setState(() => currentStep++);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                      Text("🎉 Application Submitted Successfully!")),
                );
              }
            },
            icon: Icon(
              isLastStep
                  ? Icons.check_circle_outline
                  : Icons.arrow_forward_ios,
              size: 18,
            ),
            label: Text(
              isLastStep ? "Submit" : "Next",
              style: GoogleFonts.poppins(
                fontSize: isSmall ? 13 : 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary500,
              foregroundColor: Colors.white,
              overlayColor: primary600.withOpacity(0.2),
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 12 : 24,
                vertical: 14,
              ),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

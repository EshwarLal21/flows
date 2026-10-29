import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  bool showLease = false;
  bool showPrivacy = false;
  bool showPlatform = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please read the terms and conditions carefully before signing and submitting the application.",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Lease Terms
            buildSection(
              title: "Lease Terms",
              show: showLease,
              onPressed: () => setState(() => showLease = !showLease),
              content:
              "This lease outlines the agreement between the tenant and landlord, "
                  "including rent payment schedule, property maintenance, and termination terms.",
            ),

            // Privacy Declaration
            buildSection(
              title: "Privacy Declaration",
              show: showPrivacy,
              onPressed: () => setState(() => showPrivacy = !showPrivacy),
              content:
              "We collect your information to process your application. "
                  "Your data will be handled according to privacy laws and will not be shared without consent.",
            ),

            // Platform Usage
            buildSection(
              title: "Platform Usage",
              show: showPlatform,
              onPressed: () => setState(() => showPlatform = !showPlatform),
              content:
              "By using our platform, you agree to comply with all terms of service. "
                  "Misuse or unauthorized access may result in suspension or termination of access.",
            ),

            const SizedBox(height: 24),
            const Divider(),

            // Checkboxes
            buildCheckbox(
              "I have read, understood, and agree to the lease terms and conditions outlined above.",
            ),
            buildCheckbox(
              "I acknowledge that I have read and understand the privacy declaration.",
            ),
            buildCheckbox(
              "I agree to comply with the platform terms of use and data handling policy.",
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Previous"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Next"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection({
    required String title,
    required bool show,
    required VoidCallback onPressed,
    required String content,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  ),
                  child: Text(
                    show ? "Hide" : "Click to Show",
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                ),
              ],
            ),
            if (show) ...[
              const Divider(),
              Text(
                content,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildCheckbox(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(value: false, onChanged: (_) {}),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

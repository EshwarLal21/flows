import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignAndSubmitScreen extends StatefulWidget {
  const SignAndSubmitScreen({super.key});

  @override
  State<SignAndSubmitScreen> createState() => _SignAndSubmitScreenState();
}

class _SignAndSubmitScreenState extends State<SignAndSubmitScreen> {
  bool confirmInfo = false;
  bool confirmSignature = false;
  String? signature;
  DateTime? signedDate;

  final Color primary500 = const Color(0xFF6C2EC8);
  final Color primary600 = const Color(0xFF5823B0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primary600,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        title: Text(
          "Sign & Submit Application",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please re-verify your details and provide your electronic signature to submit your application.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ✅ Confirmation checkboxes
                      buildCheckbox(
                        title:
                        "I confirm that all information provided in this application is accurate and complete.",
                        value: confirmInfo,
                        onChanged: (val) => setState(() => confirmInfo = val!),
                      ),
                      buildCheckbox(
                        title:
                        "I understand that by providing my signature, I am consenting to submit and send this application along with my personal information to the agent.",
                        value: confirmSignature,
                        onChanged: (val) =>
                            setState(() => confirmSignature = val!),
                      ),

                      const SizedBox(height: 24),

                      // ✅ Signature box
                      Card(
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Applicant Signature",
                                    style: GoogleFonts.poppins(
                                      color: primary500,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Date",
                                    style: GoogleFonts.poppins(
                                      color: primary500,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // ✅ Signature Area
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        signature = "Signed by Applicant";
                                        signedDate = DateTime.now();
                                      });
                                    },
                                    icon: const Icon(Icons.edit),
                                    label: const Text("Tap to Sign"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primary500,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      signedDate != null
                                          ? "${signedDate!.day}/${signedDate!.month}/${signedDate!.year}"
                                          : "Date will appear after signing",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),
                              Divider(color: Colors.grey.shade300),
                              const SizedBox(height: 10),

                              if (signature != null)
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    signature!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ✅ Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                              label: const Text("Previous"),
                              style: OutlinedButton.styleFrom(
                                padding:
                                const EdgeInsets.symmetric(vertical: 14),
                                foregroundColor: primary600,
                                side: BorderSide(color: primary600),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: (confirmInfo &&
                                  confirmSignature &&
                                  signature != null)
                                  ? () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "🎉 Application Submitted Successfully!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                                  : null,
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text("Submit Application"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary500,
                                disabledBackgroundColor:
                                Colors.grey.shade400.withOpacity(0.6),
                                foregroundColor: Colors.white,
                                padding:
                                const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCheckbox({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: primary500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

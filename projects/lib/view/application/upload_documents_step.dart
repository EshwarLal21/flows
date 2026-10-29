import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadDocumentsStep extends StatefulWidget {
  const UploadDocumentsStep({super.key});

  @override
  State<UploadDocumentsStep> createState() => _UploadDocumentsStepState();
}

class _UploadDocumentsStepState extends State<UploadDocumentsStep> {
  final Color primaryColor = const Color(0xFF8E24AA);

  @override
  Widget build(BuildContext context) {
    return buildCard("📄 Upload Documents", [
      const Text("📁 Document upload coming soon...",
          style: TextStyle(color: Colors.grey, fontSize: 16)),
    ]);
  }

  Widget buildCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: primaryColor)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

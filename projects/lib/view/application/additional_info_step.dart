import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditionalInfoStep extends StatefulWidget {
  final TextEditingController notesController;

  const AdditionalInfoStep({super.key, required this.notesController});

  @override
  State<AdditionalInfoStep> createState() => _AdditionalInfoStepState();
}

class _AdditionalInfoStepState extends State<AdditionalInfoStep> {
  final Color primaryColor = const Color(0xFF8E24AA);

  @override
  Widget build(BuildContext context) {
    return buildCard("📝 Additional Info", [
      TextField(
        controller: widget.notesController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: "Notes / Special Requests",
          filled: true,
          fillColor: const Color(0xFFF7F7F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
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

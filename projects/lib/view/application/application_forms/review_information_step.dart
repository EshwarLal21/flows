import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewInformationStep extends StatelessWidget {
  final TextEditingController addressController;
  final String? leaseDuration;
  final DateTime? leaseStartDate;
  final TextEditingController rentAmountController;
  final TextEditingController depositController;
  final TextEditingController notesController;

  const ReviewInformationStep({
    super.key,
    required this.addressController,
    required this.leaseDuration,
    required this.leaseStartDate,
    required this.rentAmountController,
    required this.depositController,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF8E24AA);

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
          Text("🔍 Review Information",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: primaryColor)),
          const SizedBox(height: 16),
          reviewRow("🏠 Address", addressController.text),
          reviewRow("📅 Duration", leaseDuration ?? "Not selected"),
          reviewRow("🗓 Start Date",
              leaseStartDate != null
                  ? "${leaseStartDate!.day}/${leaseStartDate!.month}/${leaseStartDate!.year}"
                  : "Not selected"),
          reviewRow("💰 Rent",
              rentAmountController.text.isEmpty ? "Not entered" : "PKR ${rentAmountController.text}"),
          reviewRow("🔒 Deposit",
              depositController.text.isEmpty ? "Not entered" : "PKR ${depositController.text}"),
          reviewRow("📝 Notes",
              notesController.text.isEmpty ? "None" : notesController.text),
        ],
      ),
    );
  }

  Widget reviewRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(title,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
          Expanded(flex: 3, child: Text(value, style: GoogleFonts.poppins())),
        ],
      ),
    );
  }
}

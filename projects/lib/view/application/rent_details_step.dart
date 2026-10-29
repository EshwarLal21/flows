import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RentDetailsStep extends StatefulWidget {
  final TextEditingController rentAmountController;
  final TextEditingController depositController;

  const RentDetailsStep({
    super.key,
    required this.rentAmountController,
    required this.depositController,
  });

  @override
  State<RentDetailsStep> createState() => _RentDetailsStepState();
}

class _RentDetailsStepState extends State<RentDetailsStep> {
  final Color primaryColor = const Color(0xFF8E24AA);

  @override
  Widget build(BuildContext context) {
    return buildCard("💰 Rent Details", [
      buildTextField("Monthly Rent (PKR)", widget.rentAmountController, TextInputType.number),
      buildTextField("Security Deposit (PKR)", widget.depositController, TextInputType.number),
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

  Widget buildTextField(String label, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF7F7F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

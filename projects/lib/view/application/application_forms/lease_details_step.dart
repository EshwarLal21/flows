import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaseDetailsStep extends StatefulWidget {
  final String? leaseDuration;
  final DateTime? leaseStartDate;
  final ValueChanged<String?> onLeaseDurationChanged;
  final ValueChanged<DateTime> onLeaseDateChanged;

  const LeaseDetailsStep({
    super.key,
    required this.leaseDuration,
    required this.leaseStartDate,
    required this.onLeaseDurationChanged,
    required this.onLeaseDateChanged,
  });

  @override
  State<LeaseDetailsStep> createState() => _LeaseDetailsStepState();
}

class _LeaseDetailsStepState extends State<LeaseDetailsStep> {
  final Color primaryColor = const Color(0xFF8E24AA);

  @override
  Widget build(BuildContext context) {
    return buildCard("📅 Lease Details", [
      buildDropdownField(
        "Lease Duration",
        ["6 Months", "1 Year", "2 Years"],
        widget.leaseDuration,
        widget.onLeaseDurationChanged,
      ),
      buildDatePicker(
        "Start Date",
        widget.leaseStartDate,
        widget.onLeaseDateChanged,
      ),
    ]);
  }

  Widget buildCard(String title, List<Widget> content) {
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
          ...content,
        ],
      ),
    );
  }

  Widget buildDropdownField(
      String label, List<String> options, String? selected, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selected,
      items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildDatePicker(String label, DateTime? date, ValueChanged<DateTime> onPicked) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: date ?? now,
            firstDate: now,
            lastDate: DateTime(now.year + 3),
          );
          if (picked != null) onPicked(picked);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          child: Text(
            date == null
                ? "Select date"
                : "${date.day}/${date.month}/${date.year}",
            style: GoogleFonts.poppins(
              color: date == null ? Colors.grey.shade600 : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

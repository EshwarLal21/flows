import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PropertyInformationStep extends StatefulWidget {
  final TextEditingController addressController;

  const PropertyInformationStep({super.key, required this.addressController});

  @override
  State<PropertyInformationStep> createState() => _PropertyInformationStepState();
}

class _PropertyInformationStepState extends State<PropertyInformationStep> {
  // 🎨 Color Palette
  final Color primary500 = const Color(0xFF6C2EC8);
  final Color primary600 = const Color(0xFF5823B0);
  final Color fieldColor = const Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Card(
        elevation: 3,
        color: Colors.white,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle('🏠 Property Information'),
              const SizedBox(height: 18),

              buildTextField('Street Address *', widget.addressController, prefixIcon: Icons.home_outlined),
              buildRowFields('Suburb *', Icons.location_city, 'State *', Icons.map),
              buildRowFields('Postcode *', Icons.pin_drop_outlined, 'Property Type *', Icons.apartment),

              const SizedBox(height: 24),
              buildSectionTitle('👤 Agent Information'),
              const SizedBox(height: 18),
              buildRowWithDropdown(
                'Agency *', Icons.business,
                'Property Manager (optional)',
                const ['Gaming Vortex'],
              ),

              const SizedBox(height: 24),
              buildSectionTitle('📅 Lease Details'),
              const SizedBox(height: 18),
              buildRowFields('Lease Term (Months) *', Icons.timelapse, 'Expected Start Date *', Icons.date_range),

              const SizedBox(height: 24),
              buildSectionTitle('💰 Rent Details'),
              const SizedBox(height: 18),
              buildRowWithDropdown(
                'Weekly Rent Amount *', Icons.attach_money,
                'Rent Frequency *',
                const ['Weekly', 'Monthly', 'Fortnightly'],
              ),
              buildRowFields('Deposit Amount (1x weekly rent)', Icons.savings_outlined,
                  'Bond Amount (4x weekly rent)', Icons.account_balance_wallet_outlined),

              const SizedBox(height: 24),
              buildSectionTitle('📝 Additional Information (optional)'),
              const SizedBox(height: 18),
              buildTextField(
                'Enter any additional information or special requests...',
                TextEditingController(),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Section Title
  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: primary600,
      ),
    );
  }

  // 🔹 Single Text Field
  Widget buildTextField(
      String label,
      TextEditingController controller, {
        int maxLines = 1,
        IconData? prefixIcon,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: label.contains('Amount') || label.contains('Postcode')
            ? TextInputType.number
            : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey[500])
              : null,
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 14),
          filled: true,
          fillColor: fieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary500, width: 1.4),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }

  // 🔹 Row with Two TextFields (Responsive)
  Widget buildRowFields(String label1, IconData icon1, String label2, IconData icon2) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              buildTextField(label1, TextEditingController(), prefixIcon: icon1),
              buildTextField(label2, TextEditingController(), prefixIcon: icon2),
            ],
          );
        } else {
          return Row(
            children: [
              Expanded(child: buildTextField(label1, TextEditingController(), prefixIcon: icon1)),
              const SizedBox(width: 12),
              Expanded(child: buildTextField(label2, TextEditingController(), prefixIcon: icon2)),
            ],
          );
        }
      },
    );
  }

  // 🔹 Row with TextField + Dropdown
  Widget buildRowWithDropdown(String label1, IconData icon1, String dropdownLabel, List<String> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              buildTextField(label1, TextEditingController(), prefixIcon: icon1),
              buildDropdown(label: dropdownLabel, items: items),
            ],
          );
        } else {
          return Row(
            children: [
              Expanded(child: buildTextField(label1, TextEditingController(), prefixIcon: icon1)),
              const SizedBox(width: 12),
              Expanded(child: buildDropdown(label: dropdownLabel, items: items)),
            ],
          );
        }
      },
    );
  }

  // 🔹 Dropdown
  Widget buildDropdown({required String label, required List<String> items}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 14),
          filled: true,
          fillColor: fieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary500, width: 1.4),
          ),
        ),
        items: items.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: GoogleFonts.poppins(fontSize: 14)),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditOccupantScreen extends StatefulWidget {
  const EditOccupantScreen({super.key});

  @override
  State<EditOccupantScreen> createState() => _EditOccupantScreenState();
}

class _EditOccupantScreenState extends State<EditOccupantScreen> {
  final _formKey = GlobalKey<FormState>();

  final relationController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();

  String gender = 'Male';
  String occupantType = 'Child';

  final Color primary = const Color(0xFF6C2EC8);
  final Color fieldColor = const Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        title: Text(
          "Edit Occupant",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Occupant Type Buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(10),
                    constraints: const BoxConstraints(minHeight: 40, minWidth: 110),
                    fillColor: primary,
                    color: Colors.black87,
                    selectedColor: Colors.white,
                    textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    isSelected: [
                      occupantType == 'Joint Applicant',
                      occupantType == 'Adult',
                      occupantType == 'Child'
                    ],
                    onPressed: (index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            occupantType = 'Joint Applicant';
                            break;
                          case 1:
                            occupantType = 'Adult';
                            break;
                          case 2:
                            occupantType = 'Child';
                            break;
                        }
                      });
                    },
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Joint Applicant'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Adult'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Child'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // All Fields (1-column layout for mobile)
                buildTextField("Relationship to Main Applicant (optional)", relationController),
                const SizedBox(height: 14),
                buildTextField("First Name (optional)", firstNameController),
                const SizedBox(height: 14),
                buildTextField("Middle Name (optional)", middleNameController),
                const SizedBox(height: 14),
                buildTextField("Last Name (optional)", lastNameController),
                const SizedBox(height: 14),
                buildTextField("Email Address (optional)", emailController, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 14),
                buildTextField("Phone Number (optional)", phoneController, keyboardType: TextInputType.phone),
                const SizedBox(height: 14),
                buildDropdownField("Gender (optional)", ["Male", "Female", "Other"]),
                const SizedBox(height: 14),
                buildDateField("Date of Birth (optional)", dobController),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel", style: GoogleFonts.poppins(color: Colors.black87)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Occupant Updated Successfully!")),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Update Occupant", style: GoogleFonts.poppins()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Text Field
  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary, width: 1.3),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }

  // 🔹 Dropdown
  Widget buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      value: gender,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
        filled: true,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary, width: 1.3),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      items: items.map((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val, style: GoogleFonts.poppins(fontSize: 14)),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          gender = value!;
        });
      },
    );
  }

  // 🔹 Date Picker
  Widget buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            controller.text = "${picked.month}/${picked.day}/${picked.year}";
          });
        }
      },
      style: GoogleFonts.poppins(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
        filled: true,
        fillColor: fieldColor,
        suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary, width: 1.3),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}

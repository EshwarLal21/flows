import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final TextEditingController agencyController =
  TextEditingController(text: "Test Agency");
  final TextEditingController addressController =
  TextEditingController(text: "71 Wellington Road");
  final TextEditingController suburbController =
  TextEditingController(text: "Auburn");
  final TextEditingController stateController =
  TextEditingController(text: "New South Wales");
  final TextEditingController postcodeController =
  TextEditingController(text: "2144");
  final TextEditingController messageController = TextEditingController();

  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusScopeNode();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => selectedTime = picked);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      resizeToAvoidBottomInset: true, // important for keyboard handling
      appBar: AppBar(
        title: Text(
          "Inspection Request",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _sectionCard(
                        title: "Property Details",
                        children: [
                          _buildReadOnlyField(
                              "Agency *", agencyController, icon: Icons.business),
                          _buildReadOnlyField("Street Address *", addressController,
                              icon: Icons.location_on_outlined),
                          _buildReadOnlyField("Suburb *", suburbController,
                              icon: Icons.home_work_outlined),
                          _buildReadOnlyField("State *", stateController,
                              icon: Icons.map_outlined),
                          _buildReadOnlyField("Postcode *", postcodeController,
                              icon: Icons.local_post_office_outlined),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _sectionCard(
                        title: "Preferred Inspection Date and Time",
                        children: [
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: _buildEditableField(
                                "Date *",
                                TextEditingController(
                                  text: selectedDate == null
                                      ? ""
                                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                ),
                                icon: Icons.calendar_today_outlined,
                                hintText: "Select inspection date",
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _selectTime(context),
                            child: AbsorbPointer(
                              child: _buildEditableField(
                                "Start Time *",
                                TextEditingController(
                                  text: selectedTime == null
                                      ? ""
                                      : selectedTime!.format(context),
                                ),
                                icon: Icons.access_time_outlined,
                                hintText: "--:-- --",
                              ),
                            ),
                          ),
                          _buildEditableField(
                            "Message from applicant (optional)",
                            messageController,
                            icon: Icons.message_outlined,
                            maxLines: 4,
                            hintText: "Enter your message",
                            onTap: () {
                              // Scroll up when focusing message
                              Future.delayed(const Duration(milliseconds: 200),
                                      () {
                                    _scrollController.animateTo(
                                      _scrollController.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeOut,
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Inspection request submitted successfully!"),
                                backgroundColor: Colors.indigo,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade800,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            "Submit",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Helper Widgets ----------

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.pink.shade400,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, TextEditingController controller,
      {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey.shade600),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(
      String label,
      TextEditingController controller, {
        IconData? icon,
        String? hintText,
        int maxLines = 1,
        VoidCallback? onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        onTap: onTap,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.grey.shade600),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddEmploymentHistoryScreen extends StatefulWidget {
  const AddEmploymentHistoryScreen({super.key});

  @override
  State<AddEmploymentHistoryScreen> createState() => _AddEmploymentHistoryScreenState();
}

class _AddEmploymentHistoryScreenState extends State<AddEmploymentHistoryScreen> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController incomeAfterTaxController = TextEditingController();
  final TextEditingController incomeBeforeTaxController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController referenceTitleController = TextEditingController();
  final TextEditingController referenceNameController = TextEditingController();
  final TextEditingController referenceEmailController = TextEditingController();
  final TextEditingController referencePhoneController = TextEditingController();

  String? selectedJobType;
  String? selectedIncomePeriod;
  DateTime? startDate;
  DateTime? endDate;
  bool isCurrentlyWorking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFF3F3F3),
            child: Icon(Icons.arrow_back, color: Colors.black87, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add Employment History",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📝 Introduction
            _buildSectionHeader(
              "Add a new employment history record.",
              subtitle: "Provide details about your company and position",
            ),
            const SizedBox(height: 24),

            // 🏢 Employment Information Section
            _buildSectionTitle("Employment Information"),
            const SizedBox(height: 16),

            // Company Name
            _buildFormField(
              "Company Name *",
              "Enter your company or organization name",
              companyNameController,
            ),
            const SizedBox(height: 16),

            // Job Type & Job Title Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Job Type *"),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        "Select job type",
                        selectedJobType,
                        ["Full-time", "Part-time", "Contract", "Freelance", "Internship"],
                            (value) {
                          setState(() {
                            selectedJobType = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    "Job Title *",
                    "Enter your job title or position",
                    jobTitleController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 💰 Income Information Section
            _buildSectionTitle("Income Information"),
            const SizedBox(height: 8),
            const Text(
              "Provide your income details for this employment",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            // Income Period
            _buildLabel("Income Period *"),
            const SizedBox(height: 8),
            _buildDropdown(
              "Select income period",
              selectedIncomePeriod,
              ["Weekly", "Bi-weekly", "Monthly", "Yearly"],
                  (value) {
                setState(() {
                  selectedIncomePeriod = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Income Amounts Row
            Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    "Income After Tax *",
                    "e.g., \$000.00",
                    incomeAfterTaxController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    "Income Before Tax *",
                    "e.g., \$0000.00",
                    incomeBeforeTaxController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 📅 Employment Period Section
            _buildSectionTitle("Employment Period"),
            const SizedBox(height: 8),
            const Text(
              "Specify when you worked at this company and if you're currently employed",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            // Currently Working Checkbox
            Row(
              children: [
                Checkbox(
                  value: isCurrentlyWorking,
                  onChanged: (value) {
                    setState(() {
                      isCurrentlyWorking = value!;
                      if (isCurrentlyWorking) {
                        endDate = null;
                      }
                    });
                  },
                  activeColor: const Color(0xFF80C904),
                ),
                const Text(
                  "I am currently working here",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Start & End Date Row
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    "Start Date *",
                    "Select start date",
                    startDate,
                        () => _selectDate(true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateField(
                    isCurrentlyWorking ? "End Date" : "End Date *",
                    "Select end date",
                    endDate,
                    isCurrentlyWorking ? null : () => _selectDate(false),
                    enabled: !isCurrentlyWorking,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (isCurrentlyWorking)
              const Text(
                "End date is not required for current employment",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            const SizedBox(height: 24),

            // 🏢 Company Address Section
            _buildSectionTitle("Company Address"),
            const SizedBox(height: 8),
            const Text(
              "Provide the address of your workplace or company",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            // Street Address
            _buildFormField(
              "Street Address *",
              "Enter street address",
              streetAddressController,
            ),
            const SizedBox(height: 16),

            // City & State Row
            Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    "City *",
                    "Enter city",
                    cityController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    "State *",
                    "Enter state",
                    stateController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Country & Post Code Row
            Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    "Country *",
                    "Enter country",
                    countryController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    "Post Code *",
                    "Enter post code",
                    postCodeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 📞 Employment Reference Section
            _buildSectionTitle("Employment Reference Information"),
            const SizedBox(height: 8),
            const Text(
              "Provide contact details for someone who can verify your employment (e.g., supervisor, HR, manager)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            // Reference Title & Name Row
            Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    "Reference Title *",
                    "Enter reference title (e.g., Manager, HR, supervisor, etc.)",
                    referenceTitleController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    "Reference Name *",
                    "Enter reference name",
                    referenceNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Reference Email & Phone Row
            Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    "Reference Email *",
                    "Enter reference email",
                    referenceEmailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    "Reference Phone *",
                    "Enter reference phone",
                    referencePhoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // ✅ Save Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF80C904),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: _saveEmploymentHistory,
                child: const Text(
                  "Save Employment History",
                  style: TextStyle(
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
    );
  }

  Widget _buildSectionHeader(String title, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E7D32),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildFormField(String label, String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String hint, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF80C904)),
        hint: Text(
          hint,
          style: const TextStyle(color: Colors.black45),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateField(String label, String hint, DateTime? date, VoidCallback? onTap, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date == null ? hint : "${date.month}/${date.day}/${date.year}",
                  style: TextStyle(
                    color: date == null ? Colors.black45 : Colors.black87,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: enabled ? const Color(0xFF80C904) : Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF80C904),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF80C904),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void _saveEmploymentHistory() {
    // Validation logic
    if (companyNameController.text.isEmpty ||
        selectedJobType == null ||
        jobTitleController.text.isEmpty ||
        selectedIncomePeriod == null ||
        incomeAfterTaxController.text.isEmpty ||
        incomeBeforeTaxController.text.isEmpty ||
        startDate == null ||
        (!isCurrentlyWorking && endDate == null) ||
        streetAddressController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        countryController.text.isEmpty ||
        postCodeController.text.isEmpty ||
        referenceTitleController.text.isEmpty ||
        referenceNameController.text.isEmpty ||
        referenceEmailController.text.isEmpty ||
        referencePhoneController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Email validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(referenceEmailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid reference email address"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Date validation
    if (endDate != null && startDate!.isAfter(endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("End date cannot be before start date"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Success case
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Employment history added successfully!"),
        backgroundColor: const Color(0xFF80C904),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    // Navigate back after success
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
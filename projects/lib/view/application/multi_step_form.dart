import 'package:flutter/material.dart';

class MultiStepForm extends StatefulWidget {
  const MultiStepForm({Key? key}) : super(key: key);

  @override
  State<MultiStepForm> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  int activeStep = 0;
  int totalSteps = 7;
  final PageController _pageController = PageController();

  void nextStep() {
    if (activeStep < totalSteps - 1) {
      setState(() => activeStep++);
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    }
  }

  void previousStep() {
    if (activeStep > 0) {
      setState(() => activeStep--);
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[50],
      appBar: AppBar(
        title: const Text(
          "Edit Rental Application",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Step Indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(totalSteps, (index) {
                      bool isActive = index == activeStep;
                      bool isCompleted = index < activeStep;

                      return Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 50,
                            height: 44,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? Colors.indigo
                                  : isActive
                                  ? Colors.indigo.shade400
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                [
                                  Icons.home,
                                  Icons.people,
                                  Icons.person,
                                  Icons.pets,
                                  Icons.directions_car,
                                  Icons.local_shipping,
                                  Icons.assignment_turned_in,
                                ][index],
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            [
                              "Lease",
                              "Occupants",
                              "Profile",
                              "Pets",
                              "Vehicles",
                              "Services",
                              "Terms"
                            ][index],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight:
                              isActive ? FontWeight.bold : FontWeight.w500,
                              color: isActive
                                  ? Colors.indigo
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),

                  // Progress Bar
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: 4,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 4,
                          width: MediaQuery.of(context).size.width *
                              (activeStep / (totalSteps - 1)),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- Step Forms ---
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  LeaseDetailsForm(),
                  OccupantsForm(),
                  ApplicantProfileForm(),
                  PetsForm(),
                  VehiclesForm(),
                  ConnectionForm(),
                  TermsForm(),
                ],
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (activeStep > 0)
                    ElevatedButton(
                      onPressed: previousStep,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400),
                      child: const Text("Back"),
                    ),
                  ElevatedButton(
                    onPressed: nextStep,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent),
                    child: Text(
                      activeStep == totalSteps - 1 ? "Finish" : "Next",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//
// ---- Forms for Each Step ----
// Each form is wrapped in SingleChildScrollView to make it scrollable and responsive.
//


class LeaseDetailsForm extends StatefulWidget {
  const LeaseDetailsForm({super.key});

  @override
  State<LeaseDetailsForm> createState() => _LeaseDetailsFormState();
}

class _LeaseDetailsFormState extends State<LeaseDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final Color primaryPurple = const Color(0xFF6A1B9A);

  // Controllers
  final streetController = TextEditingController();
  final suburbController = TextEditingController();
  final postcodeController = TextEditingController();
  final propertyTypeController = TextEditingController();
  final agencyController = TextEditingController();
  final propertyManagerController = TextEditingController();
  final durationController = TextEditingController();
  final rentAmountController = TextEditingController();
  final depositAmountController = TextEditingController();
  final bondAmountController = TextEditingController();
  final additionalInfoController = TextEditingController();

  String? selectedState;
  String? rentFrequency;
  DateTime? selectedDate;

  // States list
  final List<String> states = [
    'New South Wales',
    'Queensland',
    'Victoria',
    'Western Australia',
    'South Australia'
  ];

  // Rent Frequency
  final List<String> rentFrequencies = ['Weekly', 'Monthly'];

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lease Details Form"),
        backgroundColor: primaryPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Property Information"),
              _buildTextField(streetController, "Street Address", Icons.home, true),
              _buildTextField(suburbController, "Suburb", Icons.location_city, true),
              _buildTextField(postcodeController, "Postcode", Icons.local_post_office, true),
              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: _inputDecoration("State"),
                icon: const Icon(Icons.arrow_drop_down),
                items: states
                    .map((state) => DropdownMenuItem(value: state, child: Text(state)))
                    .toList(),
                onChanged: (val) => setState(() => selectedState = val),
                validator: (val) => val == null ? 'Required field' : null,
              ),
              const SizedBox(height: 20),

              _sectionTitle("Agent Information"),
              _buildTextField(agencyController, "Agency", Icons.apartment, true),
              _buildTextField(propertyManagerController, "Property Manager (Optional)", Icons.person),

              const SizedBox(height: 20),
              _sectionTitle("Lease Details"),
              _buildTextField(durationController, "Duration (Months)", Icons.timelapse, true, TextInputType.number),


              InkWell(
                onTap: () => _pickDate(context),
                child: InputDecorator(
                  decoration: _inputDecoration("Expected Start Date"),
                  child: Text(
                    selectedDate == null
                        ? "Select Date"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    style: TextStyle(
                        color: selectedDate == null ? Colors.grey : Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              _sectionTitle("Rent Details"),
              _buildTextField(rentAmountController, "Weekly Rent Amount", Icons.monetization_on, true,
                   TextInputType.number),
              DropdownButtonFormField<String>(
                value: rentFrequency,
                decoration: _inputDecoration("Rent Frequency"),
                icon: const Icon(Icons.arrow_drop_down),
                items: rentFrequencies
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (val) => setState(() => rentFrequency = val),
                validator: (val) => val == null ? 'Required field' : null,
              ),
              _buildTextField(depositAmountController, "Deposit Amount (1x rent)", Icons.savings,
                  true,
                 TextInputType.number),
              _buildTextField(bondAmountController, "Bond Amount (4x rent)", Icons.account_balance,
                  true,
                   TextInputType.number),

              const SizedBox(height: 20),
              _sectionTitle("Additional Information (Optional)"),
              _buildTextField(additionalInfoController,
                  "Enter any additional information or requests", Icons.note),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Form Submitted Successfully")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Next →",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
            color: primaryPurple, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryPurple, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      [bool required = false, TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: _inputDecoration(label).copyWith(prefixIcon: Icon(icon)),
        validator: required
            ? (val) => val == null || val.isEmpty ? 'Required field' : null
            : null,
      ),
    );
  }
}


class OccupantsForm extends StatelessWidget {
  const OccupantsForm({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Occupants Form"));
  }
}

class ApplicantProfileForm extends StatelessWidget {
  const ApplicantProfileForm({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Applicant Profile Form"));
  }
}

class PetsForm extends StatelessWidget {
  const PetsForm({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Pets Form"));
  }
}

class VehiclesForm extends StatelessWidget {
  const VehiclesForm({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Vehicles Form"));
  }
}

class ConnectionForm extends StatelessWidget {
  const ConnectionForm({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Connection & Moving Services"));
  }
}

class TermsForm extends StatelessWidget {
  const TermsForm({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Terms & Conditions - Sign & Submit"));
  }
}

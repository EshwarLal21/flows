import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionServicesScreen extends StatefulWidget {
  const ConnectionServicesScreen({super.key});

  @override
  State<ConnectionServicesScreen> createState() =>
      _ConnectionServicesScreenState();
}

class _ConnectionServicesScreenState extends State<ConnectionServicesScreen> {
  final List<Map<String, dynamic>> services = [
    {"name": "Electricity", "icon": Icons.flash_on, "color": Colors.redAccent, "selected": false},
    {"name": "Gas", "icon": Icons.local_fire_department, "color": Colors.purpleAccent, "selected": false},
    {"name": "Internet", "icon": Icons.public, "color": Colors.green, "selected": false},
    {"name": "Telephone", "icon": Icons.phone, "color": Colors.orange, "selected": false},
    {"name": "Pay TV", "icon": Icons.tv, "color": Colors.teal[800], "selected": false},
    {"name": "Water", "icon": Icons.water_drop, "color": Colors.pinkAccent, "selected": false},
    {"name": "Insurance", "icon": Icons.favorite_border, "color": Colors.blueAccent, "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 💬 Info Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.08),
                border: Border.all(color: Colors.deepPurple.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Please note:\nIf you don’t want to avail any connection or moving service, .",
                style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔲 Services in Vertical Step-by-Step Layout
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          service["selected"] = !service["selected"];
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: service["color"],
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: service["selected"]
                                ? Colors.white
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(service["icon"], color: Colors.white, size: 36),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                service["name"],
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              value: service["selected"],
                              onChanged: (val) {
                                setState(() {
                                  service["selected"] = val!;
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: Colors.black54,
                              side: const BorderSide(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // 📩 Footer Text
            Text(
              " connection and/or disconnection of the nominated utility products or services.",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            // ✅ Continue Button



          ],
        ),
      ),
    );
  }
}

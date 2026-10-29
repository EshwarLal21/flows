import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicantProfileScreen extends StatelessWidget {
  const ApplicantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profileSections = [
      {
        'icon': Icons.home_outlined,
        'title': 'Residential History',
        'description': 'Add details of your previous addresses',
        'records': 1,
        'color': Colors.green,
      },
      {
        'icon': Icons.work_outline,
        'title': 'Employment History',
        'description': 'Add details of your current or previous employments',
        'records': 1,
        'color': Colors.blue,
      },
      {
        'icon': Icons.credit_card_outlined,
        'title': 'Identity Documents',
        'description': 'Upload your identity verification documents',
        'records': 1,
        'color': Colors.orange,
      },
      {
        'icon': Icons.attach_money_outlined,
        'title': 'Income Documents',
        'description': 'Upload your income verification documents',
        'records': 1,
        'color': Colors.purple,
      },
      {
        'icon': Icons.school_outlined,
        'title': 'Student Profile',
        'description': 'Add your student identity details if you are a student',
        'records': 0,
        'color': Colors.pink,
      },
      {
        'icon': Icons.phone_in_talk_outlined,
        'title': 'Emergency Contacts',
        'description': 'Add your next-of-kin or emergency contacts',
        'records': 0,
        'color': Colors.red,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Applicant Profile'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Please add as many details as possible to strengthen your application",
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            ...profileSections.map(
                  (item) => _ProfileCard(
                icon: item['icon'],
                title: item['title'],
                description: item['description'],
                records: item['records'],
                color: item['color'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(title: item['title']),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final int records;
  final Color color;
  final VoidCallback onTap;

  const _ProfileCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.records,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.inter(
                          fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: records > 0
                            ? Colors.green[50]
                            : Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$records record${records != 1 ? "s" : ""}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: records > 0
                              ? Colors.green[700]
                              : Colors.orange[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.deepPurple, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;
  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          "Details for $title",
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

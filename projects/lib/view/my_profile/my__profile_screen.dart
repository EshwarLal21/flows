import 'package:flutter/material.dart';
import 'package:projects/view/my_profile/residential_history_screen.dart';
import 'package:projects/view/my_profile/student_profile_screen.dart';

import 'basic_details_screen.dart';
import 'emergency_contacts_screen.dart';
import 'employment_history_screen.dart';
import 'identity_documents_screen.dart';
import 'income_documents_screen.dart';

class BusinessProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Business 1 Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: 24),
            _buildSectionCard(
              context: context,
              title: 'Basic Details',
              subtitle: 'Manage your personal information and contact details',
              icon: Icons.person_outline,
              screen: ProfileScreen(),
            ),
            SizedBox(height: 16),
            _buildSectionCard(
              context: context,
              title: 'Income Documents',
              subtitle: 'Upload and manage your income verification documents',
              icon: Icons.attach_money_outlined,
              screen: IncomeDocumentsScreen(),
            ),
            SizedBox(height: 16),
            _buildSectionCard(
              context: context,
              title: 'Residential History',
              subtitle: 'Manage your residential address history',
              icon: Icons.home_outlined,
              screen: ResidentialHistoryScreen(),
            ),
            SizedBox(height: 16),
            _buildSectionCard(
              context: context,
              title: 'Student Profile',
              subtitle: 'Manage your student information and academic details',
              icon: Icons.school_outlined,
              screen: StudentProfileScreen(),
            ),
            SizedBox(height: 16),
            _buildSectionCard(
              context: context,
              title: 'Employment History',
              subtitle: 'Manage your employment and work experience details',
              icon: Icons.work_outline,
              screen: EmploymentHistoryScreen(),
            ),
            SizedBox(height: 16),
            _buildSectionCard(
              context: context,
              title: 'Emergency Contacts',
              subtitle: 'Manage your emergency contact information',
              icon: Icons.contact_phone_outlined,
              screen: AddEmergencyContactScreen(),
            ),
            SizedBox(height: 16),
            _buildSectionCard(
              context: context,
              title: 'Identity Documents',
              subtitle: 'Upload and manage your identity verification documents',
              icon: Icons.credit_card_outlined,
              screen: IdentityDocumentsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Manage your personal information, documents, and profile details.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16),
        Divider(
          thickness: 1,
          color: Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget screen,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.blue[700],
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey[500],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
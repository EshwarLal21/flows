import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AddPetDialog.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  final List<Map<String, String>> pets = [];

  void _openAddPetDialog() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => const AddPetDialog(),
    );

    if (result != null) {
      setState(() {
        pets.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pets"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Add all pets that will be living in the property",
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            // Show empty state or list of pets
            Expanded(
              child: pets.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  final pet = pets[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple[50],
                        child: const Icon(Icons.pets, color: Colors.deepPurple),
                      ),
                      title: Text(
                        pet['species'] ?? 'Unknown Pet',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Neutered: ${pet['neutered']}, Indoor: ${pet['indoor']}",
                        style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Buttons

          ],
        ),
      ),

    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 70, color: Colors.grey),
          const SizedBox(height: 10),
          Text(
            "No pets added yet",
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            "Add pets that will be living in the property or skip this step if you don't have any pets.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _openAddPetDialog,
            icon: const Icon(Icons.add),
            label: const Text("Add Your First Pet"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

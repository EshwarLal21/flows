import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPetDialog extends StatefulWidget {
  const AddPetDialog({super.key});

  @override
  State<AddPetDialog> createState() => _AddPetDialogState();
}

class _AddPetDialogState extends State<AddPetDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController speciesController = TextEditingController();
  String neutered = 'No';
  String indoor = 'No';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Pet"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pet Species
              TextFormField(
                controller: speciesController,
                decoration: const InputDecoration(
                  labelText: 'Pet Species *',
                  hintText: 'e.g. Dog, Cat, Bird, Fish, etc.',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter pet species' : null,
              ),
              const SizedBox(height: 16),

              // Neutered/Spayed
              DropdownButtonFormField<String>(
                value: neutered,
                decoration: const InputDecoration(
                  labelText: 'Is Neutered/Spayed (optional)',
                  border: OutlineInputBorder(),
                ),
                items: ['Yes', 'No']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => neutered = value!),
              ),
              const SizedBox(height: 16),

              // Indoor Pet
              DropdownButtonFormField<String>(
                value: indoor,
                decoration: const InputDecoration(
                  labelText: 'Indoor Only Pet (optional)',
                  border: OutlineInputBorder(),
                ),
                items: ['Yes', 'No']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => indoor = value!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'species': speciesController.text,
                'neutered': neutered,
                'indoor': indoor,
              });
            }
          },
          child: const Text("Add Pet"),
        ),
      ],
    );
  }
}

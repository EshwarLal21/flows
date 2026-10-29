import 'package:flutter/material.dart';

class EmploymentHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employment History'),
      ),
      body: Center(
        child: Text(
          'Employment History Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
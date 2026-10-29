import 'package:flutter/material.dart';

class ResidentialHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Residential History'),
      ),
      body: Center(
        child: Text(
          'Residential History Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
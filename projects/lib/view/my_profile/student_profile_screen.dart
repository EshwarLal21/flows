import 'package:flutter/material.dart';

class StudentProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: Center(
        child: Text(
          'Student Profile Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
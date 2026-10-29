import 'package:flutter/material.dart';

class IdentityDocumentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identity Documents'),
      ),
      body: Center(
        child: Text(
          'Identity Documents Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
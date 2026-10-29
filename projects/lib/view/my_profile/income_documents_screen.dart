import 'package:flutter/material.dart';

class IncomeDocumentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Documents'),
      ),
      body: Center(
        child: Text(
          'Income Documents Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
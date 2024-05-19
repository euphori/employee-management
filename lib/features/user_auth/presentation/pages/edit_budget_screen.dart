import 'package:flutter/material.dart';

class EditBudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Budget'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('Edit Budget Screen'),
        ),
      ),
    );
  }
}

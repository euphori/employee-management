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
            Navigator.pop(context); 
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            height: 148,
            width: 307,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: -1,
                  blurRadius: 7.5,
                  offset: Offset(0,3), 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

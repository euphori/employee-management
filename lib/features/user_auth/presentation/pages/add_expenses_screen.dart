import 'package:flutter/material.dart';

class AddExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expenses'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
      ),
      backgroundColor: Colors.black, // Set the background color of the entire screen
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Add Expenses Screen',
                style: TextStyle(color: Colors.white), // Set the text color to white for visibility
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money_rounded),
                      SizedBox(width: 10),
                      Text(
                        'Add Expenses',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality
                    },
                    child: Icon(Icons.add_circle_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

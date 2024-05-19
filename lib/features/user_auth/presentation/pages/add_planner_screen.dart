import 'dart:ui'; // Import for ImageFilter

import 'package:flutter/material.dart';

class AddPlannerScreen extends StatefulWidget {
  const AddPlannerScreen({super.key});

  @override
  State<AddPlannerScreen> createState() => _AddPlannerScreenState();
}

class _AddPlannerScreenState extends State<AddPlannerScreen> {
  String plannerName = ''; // Variable to store the planner name
  Map<String, double> budgets = {
    'Housing': 0,
    'Food': 0,
    'Education': 0,
  };

  bool _isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Planner', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
      ),
      backgroundColor: Color.fromARGB(255, 20, 20, 20), // Set the background color of the entire screen
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Planner Screen',
                    style: TextStyle(color: Colors.white), // Set the text color to white for visibility
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.attach_money_rounded),
                          SizedBox(width: 10),
                          Text(
                            'Planner Name',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showPlannerNameDialog(context);
                        },
                        child: const Icon(Icons.add_circle_rounded),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      for (var entry in budgets.entries) _buildItemRow(context, entry.key, entry.value.toString()),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to save the budget
                  },
                  child: const Text('Save Budget'),
                ),
              ],
            ),
          ),
          if (_isDialogOpen)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Apply blur effect
              child: Container(
                color: Colors.black.withOpacity(0.5), // Transparent black background
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              '₱$amount',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                _showEditBudgetDialog(context, title, amount);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showPlannerNameDialog(BuildContext context) async {
    setState(() {
      _isDialogOpen = true;
    });

    String? newPlannerName = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String newPlannerName = '';

        return AlertDialog(
          title: const Text('Enter Planner Name'),
          content: TextField(
            onChanged: (value) {
              newPlannerName = value;
            },
            decoration: const InputDecoration(
              hintText: 'Planner Name',
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(newPlannerName);
              },
              icon: const Icon(Icons.check),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        );
      },
    );

    setState(() {
      _isDialogOpen = false;
    });

    if (newPlannerName != null && newPlannerName.isNotEmpty) {
      setState(() {
        plannerName = newPlannerName;
      });
    }
  }

  Future<void> _showEditBudgetDialog(BuildContext context, String title, String amount) async {
    setState(() {
      _isDialogOpen = true;
    });

    String? newAmount = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String newAmount = amount;

        return AlertDialog(
          title: Text('Edit $title Budget'),
          content: TextField(
            onChanged: (value) {
              newAmount = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter new amount',
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(newAmount);
              },
              icon: const Icon(Icons.check),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        );
      },
    );

    setState(() {
      _isDialogOpen = false;
    });

    if (newAmount != null && newAmount.isNotEmpty) {
      setState(() {
        budgets[title] = double.parse(newAmount);
      });
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddPlannerScreen(),
  ));
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AddExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    final DateTime firstDay = DateTime(now.year - 1, now.month - 6, now.day);
    final DateTime lastDay = DateTime(now.year + 1, now.month + 6, now.day);

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
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TableCalendar(
                  focusedDay: today,
                  firstDay: firstDay,
                  lastDay: lastDay,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(Icons.chevron_left),
                    rightChevronIcon: Icon(Icons.chevron_right),
                  ),
                  calendarFormat: CalendarFormat.month,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Container Title',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for edit button
                        },
                        child: Icon(Icons.edit_square),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[ 
                          Text(
                          'content',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                         IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Add functionality for edit button in row
                          },
                        ),
                      ],
                      
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

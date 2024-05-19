import 'package:flutter/material.dart';
import 'dart:ui'; // Import for ImageFilter
import 'package:table_calendar/table_calendar.dart';


class AddExpensesScreen extends StatefulWidget {
  @override
  _AddPlannerScreenState createState() => _AddPlannerScreenState();
}

class _AddPlannerScreenState extends State<AddExpensesScreen> {
  String plannerName = ''; // Variable to store the planner name
  Map<String, double> budgets = {
    'Housing': 0,
    'Food': 0,
    'Education': 0,
  };

  bool _isDialogOpen = false;
  late DateTime _selectedDate;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    _selectedDate = _selectedDay;
    _calendarFormat = CalendarFormat.month;
    _events = {};
    _selectedEvents = [];
  }

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
      body: SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                          //show alertdialogue with title and dropdown box with 6 choices----------
                        },
                        child: Icon(Icons.add_circle_rounded),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: DateTime.now(),
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                        _selectedEvents = _events[selectedDay] ?? [];
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600, 
                        color: Colors.grey[100],
                      ),
                    ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      for (var entry in budgets.entries)
                        _buildItemRow(context, entry.key, entry.value.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isDialogOpen)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), 
              child: Container(
                color: Colors.black.withOpacity(0.5), 
              ),
            ),
         ],
       ),
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              '₱$amount',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () {
                _showEditBudgetDialog(context, title, amount);
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showExpensesNameDialog(BuildContext context) async {
    setState(() {
      _isDialogOpen = true;
    });

    String? newPlannerName = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String newPlannerName = '';

        return AlertDialog(
          title: Text('Add Expenses'),
          content: TextField(
            onChanged: (value) {
              newPlannerName = value;
            },
            decoration: InputDecoration(
              hintText: 'Planner Name',
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(newPlannerName);
              },
              icon: Icon(Icons.check),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
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
            decoration: InputDecoration(
              hintText: 'Enter new amount',
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(newAmount);
              },
              icon: Icon(Icons.check),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
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
  runApp(MaterialApp(
    home: AddExpensesScreen(),
  ));
}

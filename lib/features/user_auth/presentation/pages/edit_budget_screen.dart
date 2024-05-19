import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class EditBudgetScreen extends StatefulWidget {
  final double whiteHeightRatio;

  EditBudgetScreen({this.whiteHeightRatio = 0.85});

  @override
  _EditBudgetScreenState createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('MMM yyyy');

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 400,
          width: 300,
          child: TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _selectedDate,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
              Navigator.pop(context);
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarFormat: CalendarFormat.month,
          ),
        ),
      ),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Budget', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
      ),
      backgroundColor: Colors.transparent, // Make scaffold background transparent to show the gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 20, 20, 20), // Black color at the top
              Colors.white, // White color at the bottom
            ],
            stops: [1 - widget.whiteHeightRatio, 1 - widget.whiteHeightRatio], // Adjust transition point
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16), // Add padding outside the container
                  child: Container(
                    padding: EdgeInsets.all(16), // Internal padding of the container
                    height: 210,
                    width: 357,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: -1,
                          blurRadius: 7.5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Row(
                                children: [
                                  Text(
                                    "${_dateFormat.format(_selectedDate)}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.edit, // Choose the icon you need
                              color: Colors.black,
                              size: 24.0, // Adjust the size if needed
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "P1,500", // insert lang di ang budget var plis
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 60,
                              ),
                            ),
                            const Text(
                              "left",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.edit, // Edit icon
                              color: Colors.black,
                              size: 20.0, // Adjust the size as needed
                            ),
                            const Spacer(),
                            Icon(
                              Icons.edit, // Edit icon
                              color: Colors.black,
                              size: 20.0, // Adjust the size as needed
                            ),
                            const Spacer(),
                            Icon(
                              Icons.edit, // Edit icon
                              color: Colors.black,
                              size: 20.0, // Adjust the size as needed
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "P0.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "P0.00",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "P0.00",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Income",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Expenses",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Savings",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        //insert balance here
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20), // Add padding outside the container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.all(16), // Internal padding of the container
                        height: 145,
                        width: 298,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 233, 233),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildBudgetItem('Housing', 'P2,000'),
                            SizedBox(height: 8),
                            buildBudgetItem('Food', 'P1,000'),
                            SizedBox(height: 8),
                            buildBudgetItem('Education', 'P3,000'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30), // Add padding outside the container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16), // Add left padding to align text with container
                        child: Text(
                          'Yesterday',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16), // Internal padding of the container
                        height: 145,
                        width: 298,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 233, 233),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildBudgetItem('Housing', 'P2,000'),
                            SizedBox(height: 8),
                            buildBudgetItem('Food', 'P1,000'),
                            SizedBox(height: 8),
                            buildBudgetItem('Education', 'P3,000'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBudgetItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.house),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 8),
            Text(value),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hotel/features/user_auth/presentation/pages/add_expenses_screen.dart';
import 'package:hotel/features/user_auth/presentation/pages/add_planner_screen.dart';
import 'package:hotel/features/user_auth/presentation/pages/edit_budget_screen.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM yyyy').format(now);

    return Scaffold(
      appBar: AppBar(title: const Text("FinanceZ")),
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              width: 357,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: -1,
                    blurRadius: 7.5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Weekly Budget",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Text(
                        formattedDate,
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  //insert balance here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddExpensesScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline),
                            SizedBox(width: 3),
                            Text("Add Expenses"),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditBudgetScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit_square),
                            SizedBox(width: 8),
                            Text("Edit Budget"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(25),
                        height: 72,
                        width: 357,
                        child: const Text(
                          "Precious Day Expenses",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    height: 72,
                    width: 307,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: -1,
                          blurRadius: 7.5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "No Data", //insert previous day expenses
                      //insert right side, previous date (MM/DD/YYYY)
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 30),
                              height: 72,
                              width: 155,
                              child: const Text(
                                "Planners",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddPlannerScreen()),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle_outline), // Plus icon
                                  SizedBox(width: 8), // Adjust space between icon and text
                                  Text("Add Planner"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    height: 72,
                    width: 307,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: -1,
                          blurRadius: 7.5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.emoji_food_beverage_rounded, // Replace with the desired icon
                              color: Colors.black, // Replace with the desired color
                            ),
                            SizedBox(width: 8), // Adjust the spacing as needed
                            Text(
                              "No Data",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.add), // Replace with the desired icon
                          color: Colors.black, // Replace with the desired color
                          onPressed: () {
                            // Add your onPressed code here
                          },
                        ),
                      ],
                    ),
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

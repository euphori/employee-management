import 'package:flutter/material.dart';
import 'package:hotel/domain/routes/routes.dart';
import 'package:hotel/features/user_auth/presentation/widgets/home/budget_expenses.dart';
import 'package:hotel/features/user_auth/presentation/widgets/home/planner_list.dart';
import 'package:hotel/features/user_auth/presentation/widgets/home/prev_expenses.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM yyyy').format(now);

    return Scaffold(
      appBar: AppBar(title: const Text("FinanceZ")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(right: 28, left: 28, top: 20),
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
                    const SizedBox(height: 10),
                    const BudgetExpenses(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.push(context, Routes.addExpenses),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                onPressed: () => Navigator.push(context, Routes.editBudget),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const PrevExpenses(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Planners",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context, Routes.addPlanner),
                    child: const Icon(Icons.add_circle_outline_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const PlannerList(),
            ],
          ),
        ),
      ),
    );
  }
}

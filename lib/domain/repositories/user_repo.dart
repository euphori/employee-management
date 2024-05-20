import 'package:hotel/data/models/budget.dart';
import 'package:hotel/data/models/expense.dart';
import 'package:hotel/data/models/planner.dart';

class UserRepo {
  late Budget? budget = Budget();
  final Set<Expense> expenses = {};
  final Set<Planner> planners = {};

  late num currBalance = 0.0;

  Future<void> fetchData({required String userId}) async {
    final expensesData = await Expense().where('user_id', isEqualTo: userId).get();
    final budgetData = await Budget().where('user_id', isEqualTo: userId).get();
    final plannersData = await Planner().where('user_id', isEqualTo: userId).get();

    if (expenses.isEmpty || expensesData.isNotEmpty) {
      expenses.addAll(expensesData);
    }

    if (planners.isEmpty || plannersData.isNotEmpty) {
      planners.addAll(plannersData);
    }

    if (budgetData.isNotEmpty) {
      budget = budgetData.first;
    }
  }

  Future<void> addExpense({required Expense expense}) async {
    await expense.insert(expense.toJson());

    expenses.add(expense);
  }

  Future<void> updateExpense({required Expense expense}) async {
    await expense.update(expense.toJson());

    expenses.removeWhere((e) => e.id == expense.id);
    expenses.add(expense);
  }

  Future<void> deleteExpense({required String expenseId}) async {
    await Expense().where('id', isEqualTo: expenseId).delete();

    expenses.removeWhere((expense) => expense.id == expenseId);
  }

  Future<void> setBudget({required String userId}) async {
    final budgetRef = await Budget().insert({
      'user_id': userId,
      'amount': 0.0,
    });

    await budgetRef.get().then((value) {
      final data = value.data()!;
      data['id'] = value.id;

      budget = Budget.fromJson(data);
    });
  }

  Future<void> updateBudget({required num amount}) async {
    await budget?.where('id', isEqualTo: budget!.id).update({'amount': amount});

    budget = budget?.copyWith(amount: amount);
  }

  Future<void> addPlanner({required Planner planner}) async {
    await planner.insert(planner.toJson());

    planners.add(planner);
  }

  Future<void> updatePlanner({required Planner planner}) async {
    await planner.update(planner.toJson());

    planners.removeWhere((e) => e.id == planner.id);
    planners.add(planner);
  }

  Future<void> deletePlanner({required String plannerId}) async {
    await Planner().where('id', isEqualTo: plannerId).delete();

    planners.removeWhere((planner) => planner.id == plannerId);
  }
}

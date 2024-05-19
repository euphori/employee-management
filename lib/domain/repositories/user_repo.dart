import 'package:hotel/data/models/expense.dart';

class UserRepo {
  final Set<Expense> expenses = {};

  Future<void> fetchData({required String userId}) async {
    final data = await Expense().where('user_id', isEqualTo: userId).get();

    if (expenses.isEmpty) {
      expenses.addAll(data);
    }
  }
}

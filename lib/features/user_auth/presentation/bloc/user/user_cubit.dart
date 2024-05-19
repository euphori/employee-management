import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/data/models/expense.dart';
import 'package:hotel/domain/repositories/auth_repo.dart';
import 'package:hotel/domain/repositories/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AuthRepo authRepo;
  final UserRepo userRepo;

  UserCubit({required this.authRepo, required this.userRepo}) : super(UserInitial());

  Future<void> onAddExpense({required Expense expense}) async {
    emit(UserLoadingData());

    await userRepo.addExpense(expense: expense).then((value) {
      emit(UserLoadedData());
    }).catchError((error) {
      emit(UserErrorData(message: error.toString()));
    });
  }

  Future<void> onUpdateExpense({required Expense expense}) async {
    emit(UserLoadingData());

    await userRepo.updateExpense(expense: expense).then((value) {
      emit(UserLoadedData());
    }).catchError((error) {
      emit(UserErrorData(message: error.toString()));
    });
  }

  Future<void> onDeleteExpense({required String expenseId}) async {
    emit(UserLoadingData());

    await userRepo.deleteExpense(expenseId: expenseId).then((value) {
      emit(UserLoadedData());
    }).catchError((error) {
      emit(UserErrorData(message: error.toString()));
    });
  }
}

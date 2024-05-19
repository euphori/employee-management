import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/features/user_auth/presentation/bloc/user/user_cubit.dart';
import 'package:intl/intl.dart';

class PrevExpenses extends StatelessWidget {
  const PrevExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
        child: BlocBuilder<UserCubit, UserState>(
            bloc: userCubit,
            buildWhen: (prev, curr) => curr is UserLoadingData || curr is UserLoadedData || curr is UserErrorData,
            builder: (context, state) {
              if (state is UserLoadingData) {
                return const Center(child: CircularProgressIndicator());
              }

              final expense = userCubit.userRepo.expenses.where((e) => e.createdAt! == DateTime.now().subtract(const Duration(days: 1)));

              if (expense.isEmpty) {
                return const Center(child: Text("No yesterday expenses yet"));
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "₱ ${expense.first.amount!.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        expense.first.name!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy').format(expense.first.createdAt!),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

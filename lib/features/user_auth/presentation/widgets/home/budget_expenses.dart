import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/features/user_auth/presentation/bloc/user/user_cubit.dart';

class BudgetExpenses extends StatelessWidget {
  const BudgetExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    return BlocBuilder<UserCubit, UserState>(
        bloc: userCubit,
        builder: (context, state) {
          if (state is UserLoadingData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₱ ${userCubit.userRepo.budget!.amount!.toStringAsFixed(2)}",
                maxLines: 1,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 50),
              ),
              (userCubit.userRepo.expenses.isEmpty)
                  ? const Center(
                      child: Text("No expenses yet", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                    )
                  : Column(
                      children: userCubit.userRepo.expenses
                          .take(3)
                          .map((e) => ListTile(
                                title: Text(e.name!),
                                trailing: Text("₱ ${e.amount!.toStringAsFixed(2)}"),
                              ))
                          .toList(),
                    ),
              const SizedBox.shrink(),
            ],
          );
        });
  }
}

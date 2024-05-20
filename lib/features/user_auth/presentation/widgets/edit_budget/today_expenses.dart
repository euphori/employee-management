import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/features/user_auth/presentation/bloc/user/user_cubit.dart';

class TodayExpenses extends StatelessWidget {
  const TodayExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    return Card(
      color: const Color.fromARGB(255, 233, 233, 233),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<UserCubit, UserState>(
            bloc: userCubit,
            builder: (context, state) {
              if (state is UserLoadingData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (userCubit.userRepo.expenses.isEmpty) {
                return const Center(
                  child: Text('You currently have no expenses today!'),
                );
              }

              final todayExpenses = userCubit.userRepo.expenses.where((e) => e.createdAt!.day == DateTime.now().day).take(4);

              return Column(
                children: todayExpenses
                    .map((e) => ListTile(
                          leading: const Icon(Icons.attach_money_outlined),
                          title: Text(e.name!),
                          trailing: Text('₱ ${e.amount!.toStringAsFixed(2)}'),
                        ))
                    .toList(),
              );
            },
          )),
    );
  }
}

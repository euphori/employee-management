import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/features/user_auth/presentation/bloc/user/user_cubit.dart';
import 'package:hotel/features/user_auth/presentation/widgets/edit_budget/budget_info.dart';
import 'package:hotel/features/user_auth/presentation/widgets/edit_budget/today_expenses.dart';
import 'package:hotel/features/user_auth/presentation/widgets/edit_budget/yesterday_expenses.dart';
import 'package:intl/intl.dart';

class EditBudgetScreen extends StatelessWidget {
  const EditBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Budget', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 20, 20, 20),
              Colors.white,
            ],
            stops: [1 - 0.85, 1 - 0.85],
          ),
        ),
        child: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserSuccessData) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('MMM yyyy').format(DateTime.now()),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                final formKey = GlobalKey<FormState>();

                                showDialog(
                                    context: context,
                                    useRootNavigator: false,
                                    builder: (context) => AlertDialog(
                                          title: const Text('Edit Budget'),
                                          content: Form(
                                            key: formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter new budget amount';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) => userCubit.onInputBalance(amount: value),
                                                  decoration: const InputDecoration(
                                                    hintText: "Enter new budget amount",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(14)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(onPressed: () async {
                                              if (formKey.currentState!.validate()) {
                                                await userCubit.onUpdateBalance(amount: userCubit.userRepo.currBalance);

                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              }
                                            }, child: BlocBuilder<UserCubit, UserState>(
                                              builder: (context, state) {
                                                if (state is UserLoadingData) {
                                                  return const CircularProgressIndicator();
                                                } else {
                                                  return const Text('Save');
                                                }
                                              },
                                            )),
                                          ],
                                        ));
                              },
                              icon: const Icon(Icons.edit_note_outlined, color: Colors.black),
                            ),
                          ],
                        ),
                        const Expanded(child: BudgetInfo()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Today',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  const TodayExpenses(),
                  const SizedBox(height: 24),
                  const Text(
                    'Yesterday',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  const YesterdayExpenses(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

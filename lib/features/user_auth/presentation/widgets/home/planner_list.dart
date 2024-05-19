import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/features/user_auth/presentation/bloc/user/user_cubit.dart';

class PlannerList extends StatelessWidget {
  const PlannerList({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    return BlocBuilder(
        bloc: userCubit,
        buildWhen: (prev, curr) => curr is UserLoadingData || curr is UserLoadedData || curr is UserErrorData,
        builder: (context, state) {
          if (state is UserLoadingData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userCubit.userRepo.planners.isEmpty) {
            return const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.not_interested_outlined, color: Colors.black),
                    SizedBox(width: 8),
                    Text("No Planners yet", style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            );
          }

          final sortedPlanners = userCubit.userRepo.planners.toList()..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

          return Column(
            children: sortedPlanners
                .take(3)
                .map((e) => ListTile(
                      leading: const Icon(Icons.calendar_today_sharp, color: Colors.black),
                      title: Text(e.name!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                      ),
                    ))
                .toList(),
          );
        });
  }
}

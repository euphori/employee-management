import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hotel/domain/repositories/auth_repo.dart';
import 'package:hotel/domain/repositories/user_repo.dart';
import 'package:hotel/domain/routes/routes.dart';
import 'package:hotel/features/user_auth/presentation/bloc/app/app_bloc.dart';
import 'package:hotel/features/user_auth/presentation/bloc/startup/startup_bloc.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final startupBloc = StartupBloc(
      appBloc: BlocProvider.of<AppBloc>(context),
      userRepo: RepositoryProvider.of<UserRepo>(context),
      authRepo: RepositoryProvider.of<AuthRepo>(context),
    );

    return BlocListener<StartupBloc, StartupState>(
      bloc: startupBloc,
      listener: (context, state) async {
        if (state is StartupHome) {
          Navigator.of(context).pushAndRemoveUntil<void>(Routes.home, (route) => false);
        } else if (state is StartupLogin) {
          Navigator.of(context).pushAndRemoveUntil<void>(Routes.login, (route) => false);
        }

        FlutterNativeSplash.remove();
      },
      child: Container(),
    );
  }
}

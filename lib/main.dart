import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hotel/domain/repositories/auth_repo.dart';
import 'package:hotel/domain/repositories/user_repo.dart';
import 'package:hotel/features/user_auth/presentation/bloc/app/app_bloc.dart';
import 'package:hotel/features/user_auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:hotel/features/user_auth/presentation/pages/startup_page.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDhy04HiqhjRlUVZqFly7BlwovkoRlRSO4",
      appId: "1:744432325876:web:f6ae108600bad8f899faa1",
      messagingSenderId: "744432325876",
      projectId: "hotel-bcd4a",
    ));
  }
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepo()),
        RepositoryProvider(create: (_) => UserRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(create: (context) => AppBloc(authRepo: RepositoryProvider.of<AuthRepo>(context))..add(AppCheckAuth())),
          BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(
                    authRepo: RepositoryProvider.of<AuthRepo>(context),
                    userRepo: RepositoryProvider.of<UserRepo>(context),
                  )),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hotel Management',
          home: StartupPage(),
        ),
      ),
    );
  }
}

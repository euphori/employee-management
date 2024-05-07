import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotel/features/app/splash_screen/splash_screen.dart';
import 'package:hotel/features/user_auth/presentation/pages/home_page.dart';
import 'package:hotel/features/user_auth/presentation/pages/login_page.dart';
import 'package:hotel/features/user_auth/presentation/pages/sign_up_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDhy04HiqhjRlUVZqFly7BlwovkoRlRSO4",
            appId: "1:744432325876:web:f6ae108600bad8f899faa1",
            messagingSenderId: "744432325876",
            projectId: "hotel-bcd4a"));
  }
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Management',
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage()
      },
      home: SplashScreen(
        child: LoginPage(),
      ),
    );
  }
}

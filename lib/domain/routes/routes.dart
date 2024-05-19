import 'package:flutter/material.dart';
import 'package:hotel/features/user_auth/presentation/pages/home_page.dart';
import 'package:hotel/features/user_auth/presentation/pages/login_page.dart';
import 'package:hotel/features/user_auth/presentation/pages/sign_up_page.dart';

class Routes {
  static MaterialPageRoute get home => MaterialPageRoute(builder: (context) => const HomePage());
  static MaterialPageRoute get login => MaterialPageRoute(builder: (context) => const LoginPage());
  static MaterialPageRoute get signup => MaterialPageRoute(builder: (context) => const SignUpPage());
}

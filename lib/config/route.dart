import 'package:flutter/material.dart';
import 'package:kodehash_assignment/ui/login/login.dart';
import 'package:kodehash_assignment/ui/signup/signup.dart';

class Routes {
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      loginRoute: (_) => const Login(),
      signupRoute: (_) => const SignUp(),
    };
  }
}

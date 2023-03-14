import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watch/src/features/authentication/presentation/signup/signup_screen.dart';
import 'package:watch/src/features/home/presentation/home_view/home_screen.dart';
import 'package:watch/src/routes/app_routes.dart';

import '../features/authentication/presentation/login/login_screen.dart';

class AppRouter {
  ///onGenerateRoute
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const HomeScreen(),
        );
      case loginRoute:
        return PageTransition(
          curve: Curves.bounceOut,
          type: PageTransitionType.leftToRight,
          child: LoginScreen(),
        );
      case signUpRoute:
        return PageTransition(
          curve: Curves.bounceOut,
          type: PageTransitionType.leftToRight,
          child: const SignUpScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Unkonwn route')),
          ),
        );
    }
  }
}

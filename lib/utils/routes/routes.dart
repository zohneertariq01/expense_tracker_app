import 'package:expense_tracker_app/View/expense_screen.dart';
import 'package:expense_tracker_app/View/login_screen.dart';
import 'package:expense_tracker_app/View/signup_screen.dart';
import 'package:expense_tracker_app/View/splash/splash_screen.dart';
import 'package:expense_tracker_app/utils/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateSettings(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.signup:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteName.expense:
        return MaterialPageRoute(builder: (context) => ExpenseScreen());
      case RouteName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
        );
    }
  }
}

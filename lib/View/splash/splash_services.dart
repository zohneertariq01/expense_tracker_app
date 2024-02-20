import 'package:expense_tracker_app/utils/routes/route_name.dart';
import 'package:expense_tracker_app/utils/utils.dart';
import 'package:expense_tracker_app/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../../model/login_model.dart';

class SplashServices {
  Future<LoginModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RouteName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RouteName.expense);
      }
      print(value.toString());
    }).onError((error, stackTrace) {
      Utils.flushBarMessage(error.toString(), context);
      print(error.toString());
    });
  }
}

// import 'package:expense_tracker_app/View/expense_screen.dart';
// import 'package:expense_tracker_app/View/login_screen.dart';
// import 'package:expense_tracker_app/model/login_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// Future<LoginModel?> splashServices(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? authToken = prefs.getString('token');
//
//   await Future.delayed(Duration(seconds: 2));
//
//   if (authToken != null && authToken.isNotEmpty) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => ExpenseScreen()),
//     );
//   } else {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
// }

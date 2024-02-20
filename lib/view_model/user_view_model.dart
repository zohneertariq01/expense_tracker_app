import 'package:expense_tracker_app/model/login_model.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(LoginModel model) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', model.token.toString());
    return true;
  }

  Future<LoginModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return LoginModel(
      token: token.toString(),
    );
  }

  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}

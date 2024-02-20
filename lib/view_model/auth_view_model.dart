import 'package:expense_tracker_app/model/login_model.dart';
import 'package:expense_tracker_app/repository/auth_repository.dart';
import 'package:expense_tracker_app/utils/routes/route_name.dart';
import 'package:expense_tracker_app/utils/utils.dart';
import 'package:expense_tracker_app/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  void isSignUpLoading(value) {
    _signUpLoading = value;
    notifyListeners();
  }

  void isLoading(value) {
    _loading = value;
    notifyListeners();
  }

  AuthRepository _authRepository = AuthRepository();

  Future loginApi(dynamic data, BuildContext context) async {
    isLoading(true);
    _authRepository.getLoginApi(data).then((value) {
      isLoading(false);
      final provider = Provider.of<UserViewModel>(context, listen: false);
      provider.saveUser(
        LoginModel(
          token: value['token'].toString(),
        ),
      );
      Utils.flushBarMessage('Login Successfully', context);
      Navigator.pushNamed(context, RouteName.expense);
      if (kDebugMode) {
        isLoading(false);
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      isLoading(true);
      Utils.flushBarMessage(error.toString(), context);
      if (kDebugMode) {
        isLoading(false);
        print(error.toString());
      }
    });
  }

  Future signUpApi(dynamic data, BuildContext context) async {
    isSignUpLoading(true);
    _authRepository.getSignUpApi(data).then((value) {
      isSignUpLoading(false);
      Utils.flushBarMessage('Login Successfully', context);
      Navigator.pushNamed(context, RouteName.expense);
      if (kDebugMode) {
        isSignUpLoading(false);
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.flushBarMessage(error.toString(), context);
        isSignUpLoading(false);
        print(error.toString());
      }
    });
  }
}

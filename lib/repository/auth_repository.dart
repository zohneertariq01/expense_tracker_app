import 'package:expense_tracker_app/data/network/base_api_services.dart';
import 'package:expense_tracker_app/data/network/network_api_services.dart';
import 'package:expense_tracker_app/res/components/app_url.dart';

class AuthRepository {
  BaseApiServices _baseApiServices = NetworkApiServices();

  Future<dynamic> getLoginApi(dynamic data) async {
    try {
      dynamic response =
          await _baseApiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getSignUpApi(dynamic data) async {
    try {
      dynamic response =
          await _baseApiServices.getPostApiResponse(AppUrl.signupUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}

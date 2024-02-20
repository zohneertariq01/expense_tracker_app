import 'dart:convert';
import 'dart:io';
import 'package:expense_tracker_app/data/app_exception.dart';
import 'package:expense_tracker_app/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      jsonResponse = returnJson(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(url, data) async {
    dynamic jsonResponse;
    try {
      Response response =
          await post(Uri.parse(url), body: data).timeout(Duration(seconds: 10));
      jsonResponse = returnJson(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return jsonResponse;
  }

  dynamic returnJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw InvalidRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorizedRequestException(response.body.toString());
      default:
        throw FetchDataException('Error occur while communication' +
            'with status code' +
            response.statusCode.toString());
    }
  }
}

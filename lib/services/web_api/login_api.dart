import 'package:flutter/material.dart';
import 'package:homeward_interview_sample_code/services/utils/constants.dart';
import 'package:http/http.dart';

import 'api.dart';

class LoginApi {
  Api api = Api.call();
  static final LoginApi _loginApi = LoginApi._internal();

  factory LoginApi() {
    return _loginApi;
  }

  LoginApi._internal();

  // * Function to Login To API
  Future<Response?> loginToApi(String email, String password) async {
    try {
      final Uri uri = Uri.parse("${api.url()}login/");

      final Response response = await api.client().post(uri, body: {
        "email": email,
        "password": password,
      });

      return Future.value(response);
    } catch (e) {
      if (Constants.debugMode) debugPrint(e.toString());
    }
    return Future.value();
  }
}

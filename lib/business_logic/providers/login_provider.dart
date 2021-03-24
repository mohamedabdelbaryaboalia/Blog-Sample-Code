import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homeward_interview_sample_code/services/storage/prefs.dart';
import 'package:homeward_interview_sample_code/services/utils/service_locator.dart';
import 'package:homeward_interview_sample_code/services/web_api/login_api.dart';
import 'package:http/http.dart';

class LoginProvider extends ChangeNotifier {
  final Prefs _prefs = serviceLocator<Prefs>();
  final LoginApi _loginApi = serviceLocator<LoginApi>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailErrorMsg;
  String? passwordErrorMsg;

  void setEmailErrorMsg(String msg) {
    emailErrorMsg = msg;
    notifyListeners();
  }

  void setPasswordErrorMsg(String msg) {
    passwordErrorMsg = msg;
    notifyListeners();
  }

  void resetErrorMessages() {
    emailErrorMsg = null;
    passwordErrorMsg = null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool?> loginToApi() async {
    final Response? response = await _loginApi.loginToApi(
        emailController.text.trim(), passwordController.text.trim());
    print(response?.body);
    if (response != null &&
        response.statusCode == 201 &&
        response.body.isNotEmpty) {
      final Map<String, dynamic> responseMap =
          jsonDecode(response.body) as Map<String, dynamic>;
      await _prefs.write("token", responseMap['token']);
      return Future.value(true);
    }
    return Future.value();
  }

  Future<void> signOut() async {
    await _prefs.deleteAll();
  }

  Future<bool> isUserLoggedIn() async {
    final String? token = await _prefs.read("token");
    return Future.value(token != null && token.trim().isNotEmpty);
  }
}

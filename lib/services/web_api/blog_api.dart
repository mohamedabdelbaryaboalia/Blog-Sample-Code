import 'package:flutter/material.dart';
import 'package:homeward_interview_sample_code/services/utils/constants.dart';
import 'package:http/http.dart';

import 'api.dart';

class BlogApi {
  Api api = Api.call();
  static final BlogApi _blogApi = BlogApi._internal();

  factory BlogApi() {
    return _blogApi;
  }

  BlogApi._internal();
  Future<Response?> getBlogListFromApi(String token) async {
    try {
      Uri uri = Uri.parse("${api.url()}blogs");

      final Response response = await api
          .client()
          .get(uri, headers: {'Authorization': "Bearer $token"});

      return Future.value(response);
    } catch (e) {
      if (Constants.debugMode) debugPrint(e.toString());
    }
    return Future.value();
  }

  Future<Response?> getBlogEntryById(String token, int id) async {
    try {
      Uri uri = Uri.parse("${api.url()}blogs/${id.toString()}");

      final Response response = await api
          .client()
          .get(uri, headers: {'Authorization': "Bearer $token"});

      return Future.value(response);
    } catch (e) {
      if (Constants.debugMode) debugPrint(e.toString());
    }
    return Future.value();
  }
}

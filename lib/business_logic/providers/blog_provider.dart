import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homeward_interview_sample_code/business_logic/models/blog.dart';
import 'package:homeward_interview_sample_code/services/storage/prefs.dart';
import 'package:homeward_interview_sample_code/services/utils/service_locator.dart';
import 'package:homeward_interview_sample_code/services/web_api/blog_api.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' as dateTimeFormatter;

class BlogProvider extends ChangeNotifier {
  final Prefs _prefs = serviceLocator<Prefs>();
  final BlogApi _blogApi = serviceLocator<BlogApi>();
  final formatter = dateTimeFormatter.DateFormat("yyyy-MM-dd hh:mm");

  Future<List<Blog>> getBlogList() async {
    final String? token = await _prefs.read("token");
    final List<Blog> blogList = [];
    if (token != null && token.isNotEmpty) {
      Response? response = await _blogApi.getBlogListFromApi(token);

      if (response != null) {
        final List<dynamic> list = jsonDecode(response.body) as List<dynamic>;
        for (final item in list) {
          blogList.add(Blog.fromJson(item));
        }
      }
    }
    return Future.value(blogList);
  }

  Future<Blog?> getBlogItemDetails(int id) async {
    final String? token = await _prefs.read("token");
    if (token != null && token.isNotEmpty) {
      Response? response = await _blogApi.getBlogEntryById(token, id);

      if (response != null) {
        final Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        return Future.value(Blog.fromJson(json));
      }
    }
    return Future.value();
  }
}

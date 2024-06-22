import 'dart:convert';
import 'package:app_receitas_mobile/src/model/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api/apicontext.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  static String baseurl = baseUrl;

  Future<List<CategoryModel>> getCategories() async {
    var url = Uri.parse("$baseurl/api/Category/list_all_category");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("auth_token");

    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    final response = await http.get(
      url,
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['response'];
      var bodyresponse = body
          .map((dynamic item) => CategoryModel.fromJson(item['categoria']))
          .toList();

      return bodyresponse;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

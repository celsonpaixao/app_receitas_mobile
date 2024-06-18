import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import '../DTO/DTOresponse.dart';
import '../model/ratingModel.dart';

class RatingRepository {
  static String baseurl = baseUrl;

  Future<DTOresponse> publicaRating(
    int userId,
    int recipeId,
    RatingModel rating,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("auth_token");

    if (token == null) {
      return DTOresponse(success: false, message: 'Token not found');
    }

    final url = Uri.parse(
        "$baseUrl/api/Rating/public_avaliaction?id_receita=$recipeId&id_user=$userId");

    print(url);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          "value": rating.value.toString(),
          "message": rating.message!
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        var message = json.decode(response.body)['message'];
        print(message);
        return DTOresponse(success: true, message: message);
      } else {
        return DTOresponse(success: false, message: 'Failed to publish rating');
      }
    } catch (e) {
      print(e);
      return DTOresponse(success: false, message: 'An error occurred');
    }
  }

  Future<List<RatingModel>> getRatingByRecipe(int recipe_id) async {
    var url = Uri.parse(
        "$baseurl/api/Rating/list_all_avaliaction?id_receita=$recipe_id");
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
    
      List<RatingModel> recipes =
          body.map((dynamic item) => RatingModel.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}

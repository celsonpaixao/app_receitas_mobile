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

    debugPrint(url.toString());

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

      debugPrint(response.body);

      if (response.statusCode == 200) {
        var message = json.decode(response.body)['message'];
        debugPrint(message);
        return DTOresponse(success: true, message: message);
      } else {
        return DTOresponse(success: false, message: 'Failed to publish rating');
      }
    } catch (e) {
      debugPrint(e.toString());
      return DTOresponse(success: false, message: 'An error occurred');
    }
  }

  Future<DTOresponse> deletRating(int ratingId) async {
    late DTOresponse response;
    var url = Uri.parse("$baseurl/api/Rating/delete_avaliaction?id=$ratingId");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("auth_token");

    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final request = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (request.statusCode == 200) {
        var message = jsonDecode(request.body)['Avaluation deleted sucess'];

        response = DTOresponse(success: true, message: message);
      }
    } catch (e) {
      response = DTOresponse(success: false, message: e.toString());
    }

    return response;
  }

  Future<List<RatingModel>> getRatingByRecipe(int recipeId) async {
    var url = Uri.parse(
        "$baseurl/api/Rating/list_all_avaliaction?id_receita=$recipeId");
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
      debugPrint(body.toString()); // Adicionado para depuração

      List<RatingModel> ratings =
          body.map((dynamic item) => RatingModel.fromJson(item)).toList();
      return ratings;
    } else {
      debugPrint('Failed to load ratings: ${response.statusCode}');
      throw Exception('Failed to load ratings');
    }
  }
}

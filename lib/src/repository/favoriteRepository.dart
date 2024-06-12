import 'dart:convert';

import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../DTO/DTOresponse.dart';
import '../utils/api/apicontext.dart';

class FavoriteRepository {
  static String baseurl = baseUrl;

  Future<List<RecipeModel>> getReciepeFavorite(int userId) async {
    var url = Uri.parse("$baseurl/api/Favorite/list_favorite?id_user=$userId");
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
      try {
        List<dynamic> body = json.decode(response.body)['response'];
        List<RecipeModel> recipes = [];
        for (var item in body) {
          if (item['recipe'] != null) {
            for (var recipe in item['recipe']) {
              recipes.add(RecipeModel.fromJson(recipe));
            }
          }
        }
        return recipes;
      } catch (e) {
        throw Exception('Failed to decode recipes: $e');
      }
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<bool> checkInRecipe(int userId, int recipeId) async {
    var url = Uri.parse("$baseurl/api/Favorite/list_favorite?id_user=$userId");
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
      final jsonData = json.decode(response.body);
      List<dynamic> body = jsonData['response'];
      List<RecipeModel> favoriteRecipes = [];
      for (var item in body) {
        if (item['recipe'] != null) {
          for (var recipe in item['recipe']) {
            favoriteRecipes.add(RecipeModel.fromJson(recipe));
          }
        }
      }

      return favoriteRecipes.any((recipe) => recipe.id == recipeId);
    } else {
      throw Exception('Failed to fetch favorite recipes');
    }
  }

  Future<DTOresponse> addRecipeinFavorite(int userId, int recipeId) async {
    var url = Uri.parse(
        "$baseurl/api/Favorite/add_favorite?userId=$userId&recipeId=$recipeId");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("auth_token");

    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    final response = await http.post(
      url,
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String message = data['message'];
        print(message);
        return DTOresponse(
          success: true,
          message: message,
        );
      } else {
        return DTOresponse(
          success: false,
          message:
              'Failed to add recipe to favorites. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to process response: $e');
    }
  }

  Future<DTOresponse> removeRecipeinFavorite(int userId, int recipeId) async {
    var url = Uri.parse(
        "$baseurl/api/Favorite/remove_favorite?userId=$userId&recipeId=$recipeId");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("auth_token");

    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    final response = await http.delete(
      url,
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String message = data['message'];
        print(message);
        return DTOresponse(
          success: true,
          message: message,
        );
      } else {
        return DTOresponse(
          success: false,
          message:
              'Failed to add recipe to favorites. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to process response: $e');
    }
  }
}

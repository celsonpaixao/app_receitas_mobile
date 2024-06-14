import 'dart:convert';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  static String baseurl = baseUrl;

  Future<List<RecipeModel>> getRecipes() async {
    var url = Uri.parse("$baseurl/api/Recipe/list_all_recipe");
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
      List<RecipeModel> recipes =
          body.map((dynamic item) => RecipeModel.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<RecipeModel>> getRecipeByCategory(int id_category) async {
    var url = Uri.parse(
        "$baseurl/api/Recipe/list_by_recipe_category?id=$id_category");
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
      List<RecipeModel> recipes =
          body.map((dynamic item) => RecipeModel.fromJson(item)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}

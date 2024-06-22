import 'dart:convert';
import 'dart:io';
import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  static String baseurl = baseUrl;

  Future<DTOresponse> createRecipe(
      File image, RecipeModel recipe, int userId) async {
    var url = Uri.parse("$baseurl/api/Recipe/create_recipe");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("auth_token");

    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      var request = http.MultipartRequest('POST', url);

      // Set headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add fields to the request
      request.fields['title'] = recipe.title!;
      request.fields['description'] = recipe.description!;
      request.fields['instructions'] = recipe.instructions!;
      request.fields['UserId'] = userId.toString(); // Assuming userId is an int

      // Convert list fields to strings
      request.fields['Categorias'] = recipe.categorias!.join(', ');
      request.fields['Ingredients'] = recipe.ingredients!.join(', ');
      request.fields['Materials'] = recipe.materials!.join(', ');

      // Add image file if needed (assuming 'image' parameter is used for this purpose)

      // Add the image file as 'image' without specifying the filename
      var multipartFile = http.MultipartFile.fromBytes(
        'image',
        await image.readAsBytes(),
      );
      request.files.add(multipartFile);
          // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Check status code and handle response
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return DTOresponse.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to create recipe. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create recipe: $e');
    }
  }

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

   Future<List<RecipeModel>> getbestRecipes() async {
    var url = Uri.parse("$baseurl/api/Recipe/list_best_recipe");
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

  Future<List<RecipeModel>> getRecipeByCategory(int idCategory) async {
    var url = Uri.parse(
        "$baseurl/api/Recipe/list_by_recipe_category?id=$idCategory");
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

  Future<List<RecipeModel>> getRecipeByUser(int idUser) async {
    var url = Uri.parse("$baseurl/api/Recipe/list_by_recipe_user?id=$idUser");
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

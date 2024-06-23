import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  static String baseurl = baseUrl;

    Future<dynamic> addRecipe({
    required RecipeModel recipe,
    required Uint8List bytes,
    required List<int> categories,
  }) async {
    try {
      var url = Uri.parse('$baseurl/api/Recipe/create_recipe');
      var request = http.MultipartRequest('POST', url);

      // Validação de campos obrigatórios
      if (recipe.title == null || recipe.title!.isEmpty) {
        throw Exception('O título da receita é obrigatório');
      }
      if (recipe.description == null || recipe.description!.isEmpty) {
        throw Exception('A descrição da receita é obrigatória');
      }
      if (recipe.instructions == null || recipe.instructions!.isEmpty) {
        throw Exception('As instruções da receita são obrigatórias');
      }
      if (recipe.idAdmin == null) {
        throw Exception('O ID do administrador é obrigatório');
      }

      // Adicionar campos de texto
      request.fields['Title'] = recipe.title!;
      request.fields['Description'] = recipe.description!;
      request.fields['Instructions'] = recipe.instructions!;
      request.fields['UserId'] = recipe.idAdmin.toString();
      request.fields['Categorias'] = jsonEncode(categories);
      request.fields['Ingredients'] = jsonEncode(recipe.ingredients);
      request.fields['Materials'] = jsonEncode(recipe.materials);

      var multipartFile = http.MultipartFile(
        'image',
        http.ByteStream.fromBytes(bytes),
        bytes.length,
        filename: 'recipe_image.jpg', // Nome do arquivo padrão
      );
      request.files.add(multipartFile);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("auth_token");

      if (token == null) {
        throw Exception('Token not found in SharedPreferences');
      }

      // Adicionar cabeçalho de autorização com o token JWT
      request.headers['Authorization'] = 'Bearer $token';

      final response = await request.send();

      if (response.statusCode == 201) {
        var data = await response.stream.bytesToString();
        return jsonDecode(data);
      } else {
        var responseData = await response.stream.bytesToString();
        print(
            'Failed to add recipe: ${response.reasonPhrase}, Details: $responseData');
        throw Exception('Failed to add recipe: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception during recipe addition: ${e.toString()}');
      throw Exception('Failed to add recipe: ${e.toString()}');
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
    var url =
        Uri.parse("$baseurl/api/Recipe/list_by_recipe_category?id=$idCategory");
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

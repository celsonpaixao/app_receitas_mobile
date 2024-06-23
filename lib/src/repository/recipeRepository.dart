import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/utils/filters/messagefilter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  static String baseurl = baseUrl;


Future<DTOresponse> addRecipe({
    required RecipeModel recipe,
    required List<int> categories,
    required File image,
  }) async {
    DTOresponse response;
    try {
      var url = Uri.parse('$baseurl/api/Recipe/create_recipe');
      var request = http.MultipartRequest('POST', url);

      // Adicionar campos de texto
      request.fields['Title'] = recipe.title!;
      request.fields['Description'] = recipe.description!;
      request.fields['Instructions'] = recipe.instructions!;
      request.fields['UserId'] = recipe.idAdmin.toString();

      // Adicionar categorias como lista de strings
      for (var i = 0; i < categories.length; i++) {
        request.fields['Categorias[$i]'] = categories[i].toString();
      }

      // Adicionar ingredientes e materiais como listas de strings
      request.fields['Ingredients'] = recipe.ingredients!.join(',');
      request.fields['Materials'] = recipe.materials!.join(',');

      // Adicionar arquivo de imagem
      String fileName = image.path.split('/').last;
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: fileName,
      ));

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("auth_token");

      if (token == null) {
        throw Exception('Token not found in SharedPreferences');
      }

      // Adicionar cabeçalho de autorização com o token JWT
      request.headers['Authorization'] = 'Bearer $token';

      // Enviar a requisição e aguardar a resposta
      final streamedResponse = await request.send();
      final responseStream = await streamedResponse.stream.bytesToString();
      final parsedResponse = jsonDecode(responseStream);

      if (streamedResponse.statusCode == 200) {
        String message = parsedResponse['message'];
        print(message);
        response = DTOresponse(success: true, message: message);
      } else {
        String errorMessage = parsedResponse['message'] ?? 'Erro desconhecido';
        print(
            'Falha na publicação da receita: ${streamedResponse.statusCode}, $errorMessage');
        response = DTOresponse(success: false, message: errorMessage);
      }
    } catch (e) {
      print('Erro ao publicar receita: $e');
      return DTOresponse(success: false, message: "$e");
    }

    return response;
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

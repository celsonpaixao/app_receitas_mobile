import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/repository/recipeRepository.dart';

class RecipeController extends ChangeNotifier {
  final RecipeRepository? recipeRepository;
  final RecipeModel? recipeModel;

  List<RecipeModel> _listAllRecipe = [];
  List<RecipeModel> _listRecipebyCategory = [];
  List<RecipeModel> _listRecipebyUser = [];
  List<RecipeModel> _listbestReceipe = [];

  UnmodifiableListView<RecipeModel> get listAllRecipe =>
      UnmodifiableListView(_listAllRecipe);
  UnmodifiableListView<RecipeModel> get listRecipebyCategory =>
      UnmodifiableListView(_listRecipebyCategory);
  UnmodifiableListView<RecipeModel> get listRecipebyUser =>
      UnmodifiableListView(_listRecipebyUser);
  UnmodifiableListView<RecipeModel> get listbestReceipe =>
      UnmodifiableListView(_listbestReceipe);

  bool _isLoadAllList = false;
  bool get isLoadAllList => _isLoadAllList;
  bool _isLoadbyCategory = false;
  bool get isLoadbyCategory => _isLoadbyCategory;
  bool _isLoadbyUser = false;
  bool get isLoadbyUser => _isLoadbyUser;
  bool _isLoadbestRecipe = false;
  bool get isLoadbestRecipe => _isLoadbestRecipe;

  RecipeController({
    this.recipeRepository,
    this.recipeModel,
  });

  Future<void> getRecipeAll() async {
    _isLoadAllList = true;
    notifyListeners();

    var response = await recipeRepository!.getRecipes();

    _listAllRecipe = response;

    _isLoadAllList = false;
    notifyListeners();
  }

  Future<void> getRecipeByCategory(int idCategory) async {
    _isLoadbyCategory = true;
    notifyListeners();

    var response = await recipeRepository!.getRecipeByCategory(idCategory);

    _listRecipebyCategory = response;

    _isLoadbyCategory = false;
    notifyListeners();
  }

  Future<void> getRecipeByUser(int idUser) async {
    _isLoadbyUser = true;
    notifyListeners();

    var response = await recipeRepository!.getRecipeByUser(idUser);

    _listRecipebyUser = response;

    _isLoadbyUser = false;
    notifyListeners();
  }

  Future<void> filterBestReceipe() async {
    _isLoadbestRecipe = true;
    notifyListeners();
    var response = await recipeRepository!.getbestRecipes();

    _listbestReceipe = response;

    _isLoadbestRecipe = false;
    notifyListeners();
  }

  Future<void> publishRecipe({
    required String title,
    required String description,
    required String instructions,
    required int userId,
    required List<int> categories,
    required List<String> ingredients,
    required List<String> materials,
    required Uint8List bytes,
  }) async {
    try {
      _isLoadAllList = true;
      notifyListeners();

      // Criar instância do modelo de receita
      var newRecipe = RecipeModel(
        title: title,
        description: description,
        instructions: instructions,
        idAdmin: userId,
        ingredients: ingredients,
        materials: materials,
      );

      // Chamar o método de adicionar receita do repository
      await recipeRepository!
          .addRecipe(recipe: newRecipe, categories: categories, bytes: bytes);

      // Recarregar a lista de todas as receitas após publicação
      await getRecipeAll();
    } catch (e) {
      print('Exception during recipe publication: ${e.toString()}');
      throw Exception('Failed to publish recipe: ${e.toString()}');
    } finally {
      _isLoadAllList = false;
      notifyListeners();
    }
  }
}

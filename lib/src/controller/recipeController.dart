import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/repository/recipeRepository.dart';

class RecipeController extends ChangeNotifier {
  final RecipeRepository recipeRepository;
  final RecipeModel recipeModel;

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
    required this.recipeRepository,
    required this.recipeModel,
  });

  Future<void> getRecipeAll() async {
    _isLoadAllList = true;
    notifyListeners();

    var response = await recipeRepository.getRecipes();

    _listAllRecipe = response;

    _isLoadAllList = false;
    notifyListeners();
  }

  Future<void> getRecipeByCategory(int idCategory) async {
    _isLoadbyCategory = true;
    notifyListeners();

    var response = await recipeRepository.getRecipeByCategory(idCategory);

    _listRecipebyCategory = response;

    _isLoadbyCategory = false;
    notifyListeners();
  }

  Future<void> getRecipeByUser(int idUser) async {
    _isLoadbyUser = true;
    notifyListeners();

    var response = await recipeRepository.getRecipeByUser(idUser);

    _listRecipebyUser = response;

    _isLoadbyUser = false;
    notifyListeners();
  }

  Future<void> filterBestReceipe() async {
    _isLoadbestRecipe = true;
    notifyListeners();
    var response = await recipeRepository.getbestRecipes();

    _listbestReceipe = response;

    _isLoadbestRecipe = false;
    notifyListeners();
  }
}

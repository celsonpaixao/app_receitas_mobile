import 'dart:collection';
import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/repository/ratingRepository.dart';
import 'package:app_receitas_mobile/src/repository/recipeRepository.dart';
import 'package:flutter/material.dart';

class RecipeController extends ChangeNotifier {
  List<RecipeModel> _listAllRecipe = [];
  final RatingModel ratingModel;
  final RatingRepository ratingRepository;

  RecipeController({required this.ratingModel, required this.ratingRepository});

  UnmodifiableListView<RecipeModel> get listAllRecipe =>
      UnmodifiableListView(_listAllRecipe);

  bool _isLoadAllList = false;
  bool get isLoadAllList => _isLoadAllList;

  List<RecipeModel> _listRecipebyCategory = [];
  UnmodifiableListView<RecipeModel> get listRecipebyCategory =>
      UnmodifiableListView(_listRecipebyCategory);

  bool _isLoadbyCategory = false;
  bool get isLoadbyCategory => _isLoadbyCategory;

  List<RecipeModel> _listRecipebyUser = [];
  UnmodifiableListView<RecipeModel> get listRecipebyUser =>
      UnmodifiableListView(_listRecipebyUser);
  bool _isLoadbyUser = false;
  bool get isLoadbyUser => _isLoadbyUser;

  List<RecipeModel> _listbestReceipe = [];
  UnmodifiableListView<RecipeModel> get listbestReceipe =>
      UnmodifiableListView(_listbestReceipe);

  bool _isLoadbestRecipe = false;
  bool get isLoadbestRecipe => _isLoadbestRecipe;

  Future<void> getRecipeAll() async {
    _isLoadAllList = true;

    try {
      var response = await RecipeRepository().getRecipes();
      _listAllRecipe = response;
    } catch (e) {
      debugPrint('Erro ao obter todas as receitas: ${e.toString()}');
    } finally {
      _isLoadAllList = false;
      notifyListeners();
    }
  }

  Future<void> getRecipeByCategory(int idCategory) async {
    _isLoadbyCategory = true;

    try {
      var response = await RecipeRepository().getRecipeByCategory(idCategory);
      _listRecipebyCategory = response;
    } catch (e) {
      debugPrint(
          'Erro ao obter todas as receitas por categoria: ${e.toString()}');
    } finally {
      _isLoadbyCategory = false;
      notifyListeners();
    }
  }

  Future<void> getRecipeByUser(int idUser) async {
    _isLoadbyUser = true;
    try {
      var response = await RecipeRepository().getRecipeByUser(idUser);
      _listRecipebyUser = response;
    } catch (e) {
      print('Erro ao obter todas as receitas por categoria: ${e.toString()}');
    } finally {
      notifyListeners();
      _isLoadbyUser = false;
    }
  }

  Future<void> filterBestReceipe() async {
    _isLoadbestRecipe = true;

    try {
      List<RecipeModel> filteredList = [];
      for (var recipe in _listAllRecipe) {
        final ratings = await ratingRepository.getRatingByRecipe(recipe.id!);
        final media = ratingModel.calculateAverageRating(ratings);
        if (media != null && media >= 4.0) {
          filteredList.add(recipe);
        }
      }
      _listbestReceipe = filteredList;
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao filtrar melhores receitas: ${e.toString()}');
    } finally {
      _isLoadbestRecipe = false;
      notifyListeners();
    }
  }
}

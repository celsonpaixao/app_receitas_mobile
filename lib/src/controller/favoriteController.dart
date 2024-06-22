import 'dart:collection';

import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:flutter/material.dart';
import '../model/recipeModel.dart';
import '../repository/favoriteRepository.dart';

class FavoriteController extends ChangeNotifier {
  final FavoriteRepository _favoriteRepository;
  List<RecipeModel> _listFavorite = [];
  UnmodifiableListView<RecipeModel> get listFavorite =>
      UnmodifiableListView(_listFavorite);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  FavoriteController({required FavoriteRepository favoriteRepository})
      : _favoriteRepository = favoriteRepository;

  Future<void> getFavoritesRecipe(int userId) async {
    _setLoading(true);

    final response = await _favoriteRepository.getReciepeFavorite(userId);
    _updateListFavorite(response);

    _setLoading(false);
  }

  Future<void> checkInRecipe(int userId, int recipeId) async {
    _setLoading(true);

    bool isFavorite = await _favoriteRepository.checkInRecipe(userId, recipeId);
    if (isFavorite) {
      _listFavorite.add(RecipeModel(id: recipeId));
    } else {
      _listFavorite.removeWhere((recipe) => recipe.id == recipeId);
    }

    _setLoading(false);
  }

  Future<void> addRecipeInFavorite(
      int userId, int recipeId, RecipeModel recipe) async {
    _setLoading(true);

    try {
      DTOresponse response =
          await _favoriteRepository.addRecipeinFavorite(userId, recipeId);
      if (response.success) {
        _listFavorite.add(recipe);
      } else {
        throw Exception(
            'Failed to add recipe to favorites: ${response.message}');
      }
    } catch (e) {
      errorMessage = e.toString();
      print('Error adding recipe to favorites: $e');
    }

    _setLoading(false);
  }

  Future<void> removeRecipeInFavorite(
      int userId, int recipeId, RecipeModel recipe) async {
    _setLoading(true);

    try {
      DTOresponse response =
          await _favoriteRepository.removeRecipeinFavorite(userId, recipeId);
      if (response.success) {
        _listFavorite.removeWhere((recipe) => recipe.id == recipeId);
      } else {
        throw Exception(
            'Failed to remove recipe from favorites: ${response.message}');
      }
    } catch (e) {
      errorMessage = e.toString();
      print('Error removing recipe from favorites: $e');
    }

    _setLoading(false);
  }


  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _updateListFavorite(List<RecipeModel> recipes) {
    _listFavorite = recipes;
    notifyListeners();
  }
}

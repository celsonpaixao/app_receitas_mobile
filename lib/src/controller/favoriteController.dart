import 'dart:collection';

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

    if (_listFavorite.any((recipe) => recipe.id == recipeId)) {
      print('Recipe already exists in favorites!');
      return;
    }

    await _favoriteRepository.addRecipeinFavorite(userId, recipeId);
    _listFavorite.add(recipe);

    _setLoading(false);
  }

  Future<void> removeRecipeInFavorite(
      int userId, int recipeId, RecipeModel recipe) async {
    _setLoading(true);

    await _favoriteRepository.removeRecipeinFavorite(userId, recipeId);
    _listFavorite.removeWhere((recipe) => recipe.id == recipeId);

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

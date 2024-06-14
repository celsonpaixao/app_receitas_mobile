import 'dart:collection';

import 'package:flutter/material.dart';

import '../model/recipeModel.dart';
import '../repository/favoriteRepository.dart';

class FavoriteController extends ChangeNotifier {
  List<RecipeModel> _listFavorite = <RecipeModel>[];
  UnmodifiableListView<RecipeModel> get listFavorite =>
      UnmodifiableListView(_listFavorite);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getFavoritesRecipe(int userId) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners when loading starts

    try {
      final response = await FavoriteRepository().getReciepeFavorite(userId);
      _listFavorite.clear();
      _listFavorite.addAll(response); // Use addAll to update list
    } catch (e) {
      // Handle error
      print('Error fetching favorite recipes: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners when loading completes
    }
  }

  Future<void> checkInRecipe(int userId, int recipeId) async {
    try {
      bool isFavorite =
          await FavoriteRepository().checkInRecipe(userId, recipeId);
      if (isFavorite) {
        _listFavorite.add(RecipeModel(id: recipeId)); // Add to local list
      } else {
        _listFavorite.removeWhere((recipe) => recipe.id == recipeId);
      }
      notifyListeners(); // Notify listeners after updating favorite status
    } catch (e) {
      // Handle error
      print('Error checking favorite recipe: $e');
    }
  }

  Future<void> addRecipeInFavorite(int userId, int recipeId) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners when operation starts
    try {
      if (_listFavorite.any((recipe) => recipe.id == recipeId)) {
        print('Recipe already exists in favorites!');
        return;
      }

      await FavoriteRepository().addRecipeinFavorite(userId, recipeId);
      _listFavorite.add(RecipeModel(id: recipeId)); // Add to local list
      notifyListeners(); // Notify listeners after adding to favorites
    } catch (e) {
      // Handle error
      print('Error adding recipe to favorites: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners when operation completes
    }
  }

  Future<void> removeRecipeInFavorite(int userId, int recipeId) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners when operation starts
    try {
      await FavoriteRepository().removeRecipeinFavorite(userId, recipeId);
      _listFavorite.removeWhere((recipe) => recipe.id == recipeId);
      notifyListeners(); // Notify listeners after removing from favorites
    } catch (e) {
      // Handle error
      print('Error removing recipe from favorites: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners when operation completes
    }
  }
}

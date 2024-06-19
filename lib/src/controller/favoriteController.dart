import 'dart:collection';
import 'package:flutter/material.dart';
import '../model/recipeModel.dart';
import '../repository/favoriteRepository.dart';

class FavoriteController extends ChangeNotifier {
  final List<RecipeModel> _listFavorite = <RecipeModel>[];
  UnmodifiableListView<RecipeModel> get listFavorite =>
      UnmodifiableListView(_listFavorite);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  Future<void> getFavoritesRecipe(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await FavoriteRepository().getReciepeFavorite(userId);
      _listFavorite.clear();
      _listFavorite.addAll(response);
    } catch (e) {
      errorMessage = 'Error fetching favorite recipes: $e';
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkInRecipe(int userId, int recipeId) async {
    try {
      bool isFavorite =
          await FavoriteRepository().checkInRecipe(userId, recipeId);
      if (isFavorite) {
        // Adiciona o novo favorito à lista local
        _listFavorite.add(RecipeModel(id: recipeId));
        notifyListeners(); // Notifica os ouvintes para atualizar a interface
      } else {
        // Remove o favorito da lista local
        _listFavorite.removeWhere((recipe) => recipe.id == recipeId);
        notifyListeners(); // Notifica os ouvintes para atualizar a interface
      }
    } catch (e) {
      errorMessage = 'Error checking favorite recipe: $e';
      print(errorMessage);
    }
  }

  Future<void> addRecipeInFavorite(int userId, int recipeId, RecipeModel recipe) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_listFavorite.any((recipe) => recipe.id == recipeId)) {
        print('Recipe already exists in favorites!');
        return;
      }

      await FavoriteRepository().addRecipeinFavorite(userId, recipeId);
      _listFavorite.add(recipe);
      notifyListeners(); // Notifica os ouvintes para atualizar a interface
    } catch (e) {
      errorMessage = 'Error adding recipe to favorites: $e';
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeRecipeInFavorite(int userId, int recipeId, RecipeModel recipe) async {
    _isLoading = true;
    notifyListeners();

    try {
      await FavoriteRepository().removeRecipeinFavorite(userId, recipeId);
      _listFavorite.removeWhere((recipe) => recipe.id == recipeId);
      notifyListeners(); // Notifica os ouvintes para atualizar a interface
    } catch (e) {
      errorMessage = 'Error removing recipe from favorites: $e';
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

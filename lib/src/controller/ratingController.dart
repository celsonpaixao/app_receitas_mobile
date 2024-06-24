import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/repository/ratingRepository.dart';

class RatingController extends ChangeNotifier {
  final RatingRepository ratingRepository;
  final Map<int, List<RatingModel>> _ratingsByRecipe = {};
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  RatingController({required this.ratingRepository});

  UnmodifiableListView<RatingModel> getRatingsForRecipe(int recipeId) {
    return UnmodifiableListView(_ratingsByRecipe[recipeId] ?? []);
  }

  Future<void> getRatingByRecipe(int recipeId) async {
    _setLoadingState(true);
    try {
      var response = await ratingRepository.getRatingByRecipe(recipeId);
      _ratingsByRecipe[recipeId] = response;
    } catch (e) {
      print('Error fetching ratings: $e');
    } finally {
      _setLoadingState(false);
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> deleteRating(int ratingId, int recipeId) async {
    _setLoadingState(true);
    try {
      await ratingRepository.deletRating(ratingId);
      _ratingsByRecipe[recipeId]
          ?.removeWhere((rating) => rating.id == ratingId);
    } catch (e) {
      debugPrint('Error deleting rating: $e');
    } finally {
      _setLoadingState(false);
      notifyListeners();
    }
  }

  Future<void> updateRating(
      int ratingId, RatingModel rating, int recipeId) async {
    _setLoadingState(true);
    try {
      await ratingRepository.updateRating(ratingId, rating);
      var index =
          _ratingsByRecipe[recipeId]?.indexWhere((r) => r.id == ratingId);
      if (index != null && index != -1) {
        _ratingsByRecipe[recipeId]?[index] =
            rating; // Atualiza a avaliação na lista local
      }
    } catch (e) {
      debugPrint('Error updating rating: $e');
    } finally {
      _setLoadingState(false);
      notifyListeners();
    }
  }

  bool checkInAdmin(int admId, int userId) {
    return admId == userId;
  }

  Future<void> publishRating(
      int userId, int recipeId, RatingModel rating) async {
    _setLoadingState(true);
    try {
      await ratingRepository.publicaRating(userId, recipeId, rating);
      _ratingsByRecipe[recipeId]?.add(rating);
      await getRatingByRecipe(recipeId); // Refresh the list for the recipe
    } catch (e) {
      debugPrint('Error publishing rating: $e');
    } finally {
      _setLoadingState(false);
      notifyListeners();
    }
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}

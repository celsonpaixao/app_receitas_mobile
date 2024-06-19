import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/repository/ratingRepository.dart';

class RatingController extends ChangeNotifier {
  final RatingRepository ratingRepository;
  List<RatingModel> _listRating = [];
  UnmodifiableListView<RatingModel> get listRating =>
      UnmodifiableListView(_listRating);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  RatingController({required this.ratingRepository});

  Future<void> getRatingByRecipe(int recipeId) async {
    _isLoading = true;
    try {
      var response = await ratingRepository.getRatingByRecipe(recipeId);
      _listRating = response;
      print(_listRating.toString());
    } catch (e) {
      // Handle error if needed
      print('Error fetching ratings: $e');
    } finally {
      _isLoading = false;
      _isInitialized = true; // Mark as initialized after fetching ratings
      notifyListeners();
    }
  }

  Future<void> deleteRating(int ratingId) async {
    _isLoading = true;
    try {
      await ratingRepository.deletRating(ratingId);
      _listRating.removeWhere((rating) => rating.id == ratingId);
      notifyListeners();
    } catch (e) {
      // Handle error if needed
      print('Error deleting rating: $e');
    } finally {
      _isLoading = false;
    }
  }

  bool checkInAdmin(int admId, int userId) {
    if (admId == userId) {
      return true;
    }

    return false;
  }

  Future<void> publishRating(
    int userId,
    int recipeId,
    RatingModel rating,
  ) async {
    try {
      await ratingRepository.publicaRating(userId, recipeId, rating);
      _listRating.add(rating);
      notifyListeners();

      // After publishing rating, update the ratings list
      await getRatingByRecipe(recipeId);
    } catch (e) {
      // Handle error if needed
      print('Error publishing rating: $e');
    }
  }
}

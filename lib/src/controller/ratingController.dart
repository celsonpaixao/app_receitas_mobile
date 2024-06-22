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
    notifyListeners();
    try {
      var response = await ratingRepository.getRatingByRecipe(recipeId);
      _listRating = response;
      print(_listRating.toString());
    } catch (e) {
      print('Error fetching ratings: $e');
    } finally {
      _isLoading = false;
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> deleteRating(int ratingId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ratingRepository.deletRating(ratingId);
      _listRating.removeWhere((rating) => rating.id == ratingId);
      notifyListeners();
    } catch (e) {
      print('Error deleting rating: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool checkInAdmin(int admId, int userId) {
    return admId == userId;
  }

  Future<void> publishRating(
      int userId, int recipeId, RatingModel rating) async {
    try {
      await ratingRepository.publicaRating(userId, recipeId, rating);
      _listRating.add(rating);
      notifyListeners();
      await getRatingByRecipe(recipeId);
    } catch (e) {
      print('Error publishing rating: $e');
    }
  }
}

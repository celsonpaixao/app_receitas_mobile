import 'dart:collection';

import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/repository/ratingRepository.dart';
import 'package:flutter/material.dart';

class RatingController extends ChangeNotifier {
  final List<RatingModel> _listRating = [];
  UnmodifiableListView<RatingModel> get listRating =>
      UnmodifiableListView(_listRating);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isInitialized = false; // Define isInitialized property
  bool get isInitialized => _isInitialized;

  bool get hasError => _errorMessage != null;

  Future<void> getRatingByRecipe(int recipeId) async {
    _setLoading(true);
    try {
      var response = await RatingRepository().getRatingByRecipe(recipeId);
      _listRating.clear();
      _listRating.addAll(response);
      _setErrorMessage(null);
      _setInitialized(true); // Set isInitialized to true after successful fetch
    } catch (e) {
      _setErrorMessage('Failed to fetch ratings: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> publishRating(
      int userId, int recipeId, RatingModel rating) async {
    _setLoading(true);
    try {
      await RatingRepository().publicaRating(userId, recipeId, rating);
      _listRating.add(rating);
      _setErrorMessage(null);
      notifyListeners();
    } catch (e) {
      _setErrorMessage('Failed to publish rating: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setInitialized(bool value) {
    _isInitialized = value;
    notifyListeners();
  }
}

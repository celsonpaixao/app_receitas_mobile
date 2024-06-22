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
    print(_listRating.toString()); // Verifique se há avaliações aqui
  } catch (e) {
    print('Error fetching ratings: $e');
  } finally {
    _isLoading = false;
    _isInitialized = true;
    notifyListeners();
  }
}


  Future<void> deleteRating(int ratingId) async {
    _setLoadingState(true);
    try {
      await ratingRepository.deletRating(ratingId);
      _listRating.removeWhere((rating) => rating.id == ratingId);
    } catch (e) {
      debugPrint('Error deleting rating: $e');
    } finally {
      _setLoadingState(false);
      notifyListeners();
    }
  }

  Future<void> updateRating(int ratingId, RatingModel rating) async {
    _setLoadingState(true);
    try {
      await ratingRepository.updateRating(ratingId, rating);
      await getRatingByRecipe(rating.id!); // Recarrega as avaliações da receita
    } catch (e) {
      debugPrint('Error updating rating: $e');
    } finally {
      _setLoadingState(false);
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
      _listRating.add(rating);
      await getRatingByRecipe(recipeId);
    } catch (e) {
      debugPrint('Error publishing rating: $e');
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}

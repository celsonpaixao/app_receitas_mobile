
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/repository/favoriteRepository.dart';
import 'package:get/get.dart';

import '../DTO/DTOresponse.dart';

class FavoriteController extends GetxController {
  final List<RecipeModel> _listfavorite = <RecipeModel>[].obs;
  List<RecipeModel> get listfavorite => _listfavorite;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  Future<void> getFavoritesRecipe(int userId) async {
    _isLoading.value = true;

    try {
      final response = await FavoriteRepository().getReciepeFavorite(userId);
      _listfavorite.assignAll(response);
    } catch (e) {
      // Tratar erro
      print('Erro ao obter receitas favoritas: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> checkInRecipe(int userId, int recipeId) async {
    return FavoriteRepository().checkInRecipe(userId, recipeId);
  }

  Future<DTOresponse> addRecipeinFavorite(int userId, int recipeId) async {
    return FavoriteRepository().addRecipeinFavorite(userId, recipeId);
  }

  Future<DTOresponse> removeRecipeinFavorite(int userId, int recipeId) async {
    return FavoriteRepository().removeRecipeinFavorite(userId, recipeId);
  }
}

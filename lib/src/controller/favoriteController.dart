import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/repository/favoriteRepository.dart';

import '../DTO/DTOresponse.dart';

class FavoriteController {
  Future<List<RecipeModel>> getFavoritesRecipe(int userId) async {
    return FavoriteRepository().getReciepeFavorite(userId);
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

import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/repository/recipeRepository.dart';

class RecipeController {
  Future<List<RecipeModel>> getRecipeAll() async {
    return RecipeRepository().getRecipes();
  }
}
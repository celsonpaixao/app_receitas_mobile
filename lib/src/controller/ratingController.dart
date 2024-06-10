import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/repository/ratingRepository.dart';

class RatingController {
  Future<DTOresponse> publicRating(
      int userId, int recipeId, RatingModel rating) async {
    return RatingRepository().publicaRating(userId, recipeId, rating);
  }
}

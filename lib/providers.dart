import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/repository/ratingRepository.dart';
import 'package:provider/provider.dart';

import 'src/controller/categoryController.dart';
import 'src/controller/favoriteController.dart';
import 'src/controller/ratingController.dart';
import 'src/controller/recipeController.dart';
import 'src/controller/userController.dart';
import 'src/repository/categoryRepository.dart';
import 'src/utils/auth/tokendecod.dart';

final providers = [
  ChangeNotifierProvider<TokenDecod>(
    create: (_) => TokenDecod(),
    lazy: false,
  ),

  ChangeNotifierProvider<UserController>(
    create: (_) => UserController(),
  ),

  Provider(
    create: (_) => RatingModel(),
  ),

  Provider<RatingRepository>(
    create: (_) => RatingRepository(),
  ),

  Provider<CategoryRepository>(
    create: (_) => CategoryRepository(),
    lazy: false,
  ),

  ChangeNotifierProvider<RecipeController>(
    create: (context) => RecipeController(
        ratingModel: context.read<RatingModel>(),
        ratingRepository: context.read<RatingRepository>()),
  ),
  ChangeNotifierProvider<RatingController>(
    create: (context) =>
        RatingController(ratingRepository: context.read<RatingRepository>()),
  ),

  ChangeNotifierProvider<CategoryController>(
    create: (context) => CategoryController(
      repository: context.read<CategoryRepository>(),
    ),
  ),

  ChangeNotifierProvider<FavoriteController>(
    create: (_) => FavoriteController(),
  ),
];

import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/repository/ratingRepository.dart';
import 'package:app_receitas_mobile/src/repository/userRepository.dart';
import 'package:provider/provider.dart';

import 'src/controller/categoryController.dart';
import 'src/controller/favoriteController.dart';
import 'src/controller/ratingController.dart';
import 'src/controller/recipeController.dart';
import 'src/controller/userController.dart';
import 'src/repository/categoryRepository.dart';
import 'src/repository/favoriteRepository.dart';
import 'src/repository/recipeRepository.dart';
import 'src/utils/auth/tokendecod.dart';

final providers = [
  // Provedores para modelos e repositórios
  Provider<RecipeModel>(
    create: (_) => RecipeModel(),
  ),
  Provider<CategoryRepository>(
    create: (_) => CategoryRepository(),
    lazy: false,
  ),
  Provider<RecipeRepository>(
    create: (_) => RecipeRepository(),
  ),
  Provider<RatingRepository>(
    create: (_) => RatingRepository(),
  ),

  Provider<FavoriteRepository>(
    create: (_) => FavoriteRepository(),
  ),

  Provider<UserRepository>(
    create: (_) => UserRepository(),
  ),
  // Provedores para controladores
  ChangeNotifierProvider<RecipeController>(
    create: (context) => RecipeController(
      recipeRepository: context.read<RecipeRepository>(),
      recipeModel: context.read<RecipeModel>(),
    ),
  ),
  ChangeNotifierProvider<CategoryController>(
    create: (context) => CategoryController(
      repository: context.read<CategoryRepository>(),
    ),
  ),
  ChangeNotifierProvider<FavoriteController>(
    create: (context) => FavoriteController(
        favoriteRepository: context.read<FavoriteRepository>()),
  ),
  ChangeNotifierProvider<RatingController>(
    create: (context) => RatingController(
      ratingRepository: context.read<RatingRepository>(),
    ),
  ),

  // Provedores para autenticação e usuário
  ChangeNotifierProvider<TokenDecod>(
    create: (_) => TokenDecod(),
  ),
  ChangeNotifierProvider<UserController>(
    create: (context) =>
        UserController(repository: context.read<UserRepository>()),
  ),
];

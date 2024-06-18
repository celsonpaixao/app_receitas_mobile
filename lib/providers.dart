import 'package:provider/provider.dart';

import 'src/controller/categoryController.dart';
import 'src/controller/favoriteController.dart';
import 'src/controller/ratingController.dart';
import 'src/controller/recipeController.dart';
import 'src/controller/userController.dart';
import 'src/repository/categoryRepository.dart'; // Importe do repository
import 'src/utils/auth/tokendecod.dart';

final providers = [
  // Provedor para TokenDecod (se precisar acessar o token decodificado)
  ChangeNotifierProvider<TokenDecod>(
    create: (_) => TokenDecod(),
    lazy: false,
  ),

  // Provedor para UserController
  ChangeNotifierProvider<UserController>(
    create: (_) => UserController(),
  ),

  // Provedor para RecipeController
  ChangeNotifierProvider<RecipeController>(
    create: (_) => RecipeController(),
  ),

  // Provedor para RatingController
  ChangeNotifierProvider<RatingController>(
    create: (_) => RatingController(),
  ),

  // Provedor para CategoryRepository (lazy: false se não precisar de carregamento preguiçoso)
  Provider<CategoryRepository>(
    create: (_) => CategoryRepository(),
    lazy: false,
  ),

  // Provedor para CategoryController, com acesso ao CategoryRepository
  ChangeNotifierProvider<CategoryController>(
    create: (context) => CategoryController(
      repository: context.read<CategoryRepository>(),
    ),
  ),

  // Provedor para FavoriteController
  ChangeNotifierProvider<FavoriteController>(
    create: (_) => FavoriteController(),
  ),
];

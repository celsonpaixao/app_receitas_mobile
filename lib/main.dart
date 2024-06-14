import 'package:app_receitas_mobile/src/controller/categoryController.dart';
import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app_receitas_mobile/src/utils/auth/authrouterpage.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';

import 'package:app_receitas_mobile/src/view/styles/colores.dart';

import 'src/controller/favoriteController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configura todas as dependências
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TokenDecod()),
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => RecipeController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => FavoriteController()),
        // Adicione outros providers aqui se necessário
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DishDash',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: primaryWhite,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            surfaceTintColor: primaryAmber,
          ),
        ),
        home: AuthRouterPage(),
      ),
    );
  }
}

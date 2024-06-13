import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_receitas_mobile/src/utils/auth/authrouterpage.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/repository/categoryRepository.dart';
import 'package:app_receitas_mobile/src/controller/favoriteController.dart'; // Importe o FavoriteController
import 'package:app_receitas_mobile/src/view/styles/colores.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpDependencies(); // Configura todas as dependências
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DishDash',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: primaryWhite,
        appBarTheme:  AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          surfaceTintColor: primaryAmber,
        ),
      ),
      home: AuthRouterPage(),
    );
  }
}

Future<void> setUpDependencies() async {
  try {
    var user = await decodeUser();
    Get.put<UserToken>(user);
  } catch (e) {
    print('Failed to set UserToken: $e');
  }
  Get.lazyPut<CategoryRepository>(() => CategoryRepository());
  Get.put(FavoriteController()); 
}

import 'package:app_receitas_mobile/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app_receitas_mobile/src/utils/auth/authrouterpage.dart';

import 'package:app_receitas_mobile/src/view/styles/colores.dart';


void main() async {

  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DishDash',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: primaryWhite,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            surfaceTintColor: primaryAmber,
          ),
        ),
        home: const AuthRouterPage(),
      ),
    );
  }
}

import 'package:app_receitas_mobile/src/utils/auth/authrouterpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

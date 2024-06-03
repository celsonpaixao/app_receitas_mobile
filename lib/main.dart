import 'package:app_receitas_mobile/src/view/pages/splashpage.dart';
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
      title: 'DishDash',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            surfaceTintColor: primaryAmber),
      ),
      home: SplashPage(),
    );
  }
}

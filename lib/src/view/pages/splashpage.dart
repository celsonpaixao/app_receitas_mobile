import 'package:app_receitas_mobile/src/utils/auth/authrouterpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const AuthRouterPage(),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
 
    return Container(
      decoration: BoxDecoration(
        color: primaryGreen,
      ),
      child: Center(
        child: Image.asset(
          "assets/images/Dish Dash Logo.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

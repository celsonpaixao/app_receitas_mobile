import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future<bool> logout() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.clear();

      // Navegar para a página de login após o logout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );

      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: LayoutPage(
        body: Column(
          children: [
            GlobalButton(
              textButton: "Sair",
              onClick: logout,
              background: primaryAmber,
              textColor: primaryWite,
            )
          ],
        ),
      ),
    );
  }
}

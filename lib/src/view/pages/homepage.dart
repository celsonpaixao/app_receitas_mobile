import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user; // Inicialize user com um valor padrão

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    var decodedUser = await decodeUser();
    setState(() {
      user = decodedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> logout() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.clear();

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
        backgroundColor: primaryAmber,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        surfaceTintColor: primaryAmber,
        title: Text(
          user.firstName != null
              ? "Olá... ${user.firstName} ☺️"
              : "Carregando...!",
          style: TextStyle(
            color: primaryWite,
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
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

import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutPage(
        body: Center(
          child: GlobalButton(
            textButton: "Sair",
            onClick: logout,
            background: primaryAmber,
            textColor: primaryWhite,
          ),
        ),
      ),
    );
  }
}

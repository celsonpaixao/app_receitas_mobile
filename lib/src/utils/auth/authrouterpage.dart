import 'package:app_receitas_mobile/src/utils/auth/authtoken.dart';
import 'package:app_receitas_mobile/src/view/pages/welcomepage.dart';
import 'package:flutter/material.dart';

import '../../view/pages/homepage.dart';

class AuthRouterPage extends StatefulWidget {
  const AuthRouterPage({super.key});

  @override
  State<AuthRouterPage> createState() => _AuthRouterPageState();
}

class _AuthRouterPageState extends State<AuthRouterPage> {
  @override
  void initState() {
    super.initState();
    AuthToken().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomePage(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final tokenController = Provider.of<TokenDecod>(context, listen: false);
      final decodedUser = await tokenController.decodeUser();
      setState(() {
        user = decodedUser;
      });
    } catch (e) {
      print('Error loading user: $e');
    }
  }

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
      appBar: GlobalAppBar(
        title: Consumer<TokenDecod>(
          builder: (context, token, child) {
            return Text(
              user != null
                  ? "${user!.firstName} ${user!.lastName}"
                  : "Carregando...!",
              style: TextStyle(
                color: primaryWhite,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            );
          },
        ),
        titlecenter: true,
        
      ),
      body: LayoutPage(
        body: Column(
          children: [
            Center(
              child: GlobalButton(
                textButton: "Sair",
                onClick: logout,
                background: primaryAmber,
                textColor: primaryWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

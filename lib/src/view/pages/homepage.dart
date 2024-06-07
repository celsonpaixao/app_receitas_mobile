import 'package:app_receitas_mobile/src/repository/categoryRepository.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalsearchinput.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/categoryModel.dart';
import '../components/tabcategorys.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserToken? user;
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadCategory();
  }

  void _loadUser() async {
    UserToken decodedUser = await decodeUser();
    setState(() {
      user = decodedUser;
    });
  }

  void _loadCategory() async {
    List<CategoryModel> getCategories =
        await CategoryRepository().getCategorys();
    setState(() {
      categories = getCategories;
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
      backgroundColor: primaryWite,
      appBar: AppBar(
        backgroundColor: primaryAmber,
        toolbarHeight: 150,
        flexibleSpace: Container(
          alignment: Alignment.topRight,
          child: Image.asset("assets/images/appbarover.png"),
        ),
        surfaceTintColor: primaryAmber,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user != null && user!.firstName.isNotEmpty
                  ? "Olá... ${user!.firstName} ☺️"
                  : "Carregando...!",
              style: TextStyle(
                color: primaryWite,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Spacing(value: .02),
            GlobalSearchInput(),
          ],
        ),
      ),
      body: Container(
        child: TabCategory(),
      ),
    );
  }
}

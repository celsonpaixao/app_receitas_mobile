import 'package:app_receitas_mobile/src/repository/categoryRepository.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/listrecipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: primaryWhite,
      appBar: GlobalAppBar(
        height: 150,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user != null && user!.firstName.isNotEmpty
                  ? "Olá... ${user!.firstName} ☺️"
                  : "Carregando...!",
              style: TextStyle(
                color: primaryWhite,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Spacing(value: .02),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListRecipePage(),
                    ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    color: primaryWhite.withOpacity(.3),
                    border: Border.all(color: primaryWhite),
                    borderRadius: BorderRadius.circular(9)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: primaryWhite,
                        size: 25,
                      ),
                      Text(
                        "Procurar Receita...!",
                        style: TextStyle(color: primaryWhite, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: TabCategory(),
      ),
    );
  }
}

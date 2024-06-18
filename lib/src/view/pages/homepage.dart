import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/listrecipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/categoryController.dart';
import '../components/tabcategorys.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 UserModel? user;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUser();
    await _loadCategory();
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

  Future<void> _loadCategory() async {
    try {
      final categoryController =
          Provider.of<CategoryController>(context, listen: false);
      await categoryController.getCategoryList();
    } catch (e) {
      print('Error loading categories: $e');
    }
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
            Consumer<TokenDecod>(
              builder: (context, token, child) {
                return Text(
                  user != null
                      ? "Olá... ${user!.firstName} ☺️"
                      : "Carregando...!",
                  style: white_text_title
                );
              },
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
      body: TabCategory(),
    );
  }
}

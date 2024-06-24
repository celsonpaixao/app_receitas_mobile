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
  final UserModel user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadCategory();
  }

  Future<void> _loadCategory() async {
    try {
      final categoryController =
          Provider.of<CategoryController>(context, listen: false);
      categoryController.listCategories;
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
            Text(
                widget.user != null
                    ? "Olá... ${widget.user!.firstName} ☺️"
                    : "Carregando...!",
                style: white_text_title),
            const Spacing(value: .02),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListRecipePage(),
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
      body: TabCategory(
        user: widget.user,
      ),
    );
  }
}

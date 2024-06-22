import 'dart:async';
import 'package:app_receitas_mobile/src/view/components/globaldialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/controller/ratingController.dart';
import 'package:app_receitas_mobile/src/controller/userController.dart'; // Importe o controller de usuário
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/minicardrecipe.dart';
import 'package:app_receitas_mobile/src/view/components/minicardshimmer.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:app_receitas_mobile/src/view/pages/updateuserpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import '../../utils/api/apicontext.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  late RecipeController recipe;

  @override
  void initState() {
    super.initState();
    recipe = Provider.of(context, listen: false);
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final tokenController = Provider.of<TokenDecod>(context, listen: false);
      final decodedUser = await tokenController.decodeUser();
      setState(() {
        user = decodedUser;
      });
      if (user?.id != null) {
        await recipe.getRecipeByUser(user!.id!);
      }
    } catch (e) {
      print('Error loading user: $e');
    }
  }

  Future<void> logout() async {
    var cond = await UserController().LogoutUser();
    if (cond == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  void _confirmLogout() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // Evita fechar o dialogo clicando fora
      builder: (BuildContext context) {
        return GlobalDialog(
          onConfirm: logout, 
          text: "Você está tentado sair",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user != null
                  ? "${user!.firstName} ${user!.lastName}"
                  : "Carregando...!",
              style: white_text_title,
            ),
            IconButton(
              onPressed:
                  _confirmLogout, // Chama o método de confirmação de logout
              icon: Icon(
                Icons.logout,
                color: primaryWhite,
              ),
            )
          ],
        ),
        titlecenter: true,
      ),
      body: Consumer<TokenDecod>(
        builder: (context, usercontroller, child) {
          final ratings = Provider.of<RatingController>(context, listen: false);
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return LayoutPage(
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacing(value: .04),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: secundaryGrey,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            user?.imageURL != null && user!.imageURL!.isNotEmpty
                                ? NetworkImage("$baseUrl/${user!.imageURL!}")
                                : const AssetImage(
                                    "assets/images/Depositphotos_484354208_S.jpg",
                                  ) as ImageProvider,
                      ),
                    ),
                  ),
                  const Spacing(value: .04),
                  MaterialButton(
                    minWidth: 100,
                    height: 45,
                    color: primaryAmber,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Editar",
                      style: TextStyle(color: primaryWhite),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateUserPage(userdate: user!),
                        ),
                      );
                    },
                  ),
                  const Spacing(value: .04),
                  const Text(
                    "Suas receitas",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Consumer<RecipeController>(
                      builder: (context, recipecontroller, child) {
                        if (recipecontroller.isLoadbyUser) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 5,
                              childAspectRatio: .65,
                            ),
                            itemBuilder: (context, index) {
                              return const MiniCardRecipeShimmer();
                            },
                          );
                        } else if (recipecontroller.listRecipebyUser.isEmpty) {
                          return const Center(
                            child: Text(
                                "Você ainda não publicou nehuma receita..!!"),
                          );
                        } else {
                          return GridView.builder(
                            itemCount: recipecontroller.listRecipebyUser.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 5,
                              childAspectRatio: .65,
                            ),
                            itemBuilder: (context, index) {
                              var item =
                                  recipecontroller.listRecipebyUser[index];

                              ratings.getRatingByRecipe(item.id!);
                              return MiniCardRecipe(
                                item: item,
                                ratings: ratings.listRating,
                              );
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:app_receitas_mobile/src/controller/ratingController.dart';
import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/controller/userController.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/globaldialog.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/minicardrecipe.dart';
import 'package:app_receitas_mobile/src/view/components/minicardshimmer.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/updateuserpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatefulWidget {
  final UserController userController;
  final UserModel user;

  const ProfilePage({
    Key? key,
    required this.user,
    required this.userController,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _confirmLogout() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GlobalDialog(
          onConfirm: () async {
            await widget.userController.logoutUser(context);
          },
          text: "Você está tentando sair",
        );
      },
    );
  }

  void clickEditar() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GlobalDialog(
          onConfirm: () {
            // Feche o diálogo e navegue para a página de atualização do usuário
            Navigator.of(context).pop();

            // Use o Future.delayed para garantir que o diálogo seja fechado antes da navegação
            Future.delayed(Duration(milliseconds: 100), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateUserPage(
                    userdate: widget.user,
                    userController: widget.userController,
                  ),
                ),
              );
            });
          },
          text: "Você quer editar as informações do usuário?",
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
              widget.user != null
                  ? "${widget.user.firstName} ${widget.user.lastName}"
                  : "Carregando...!",
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              onPressed: _confirmLogout,
              icon: Icon(Icons.logout, color: Colors.white),
            )
          ],
        ),
        titlecenter: true,
      ),
      body: Consumer<TokenDecod>(
        builder: (context, usercontroller, child) {
          final ratings = Provider.of<RatingController>(context, listen: false);
          if (widget.user == null) {
            return Center(child: CircularProgressIndicator());
          }
          return LayoutPage(
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacing(value: .04),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: secundaryGrey,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: widget.user.imageURL != null &&
                                widget.user.imageURL!.isNotEmpty
                            ? NetworkImage("$baseUrl/${widget.user.imageURL!}")
                            : const AssetImage(
                                "assets/images/Depositphotos_484354208_S.jpg",
                              ) as ImageProvider,
                      ),
                    ),
                  ),
                  Spacing(value: .04),
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
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: clickEditar,
                  ),
                  Spacing(value: .04),
                  Text(
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
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 5,
                              childAspectRatio: .65,
                            ),
                            itemBuilder: (context, index) {
                              return MiniCardRecipeShimmer();
                            },
                          );
                        } else if (recipecontroller.listRecipebyUser.isEmpty) {
                          return Center(
                            child: Text(
                              "Você ainda não publicou nenhuma receita!",
                            ),
                          );
                        } else {
                          return GridView.builder(
                            itemCount: recipecontroller.listRecipebyUser.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                user: widget.user,
                                item: item,
                                ratings: ratings.listRating,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/view/components/globalprogress.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';

class CardRecipeUser extends StatefulWidget {
  final RecipeModel recipe;
  final RecipeController recipeController;

  const CardRecipeUser({
    Key? key,
    required this.recipe,
    required this.recipeController,
  }) : super(key: key);

  @override
  State<CardRecipeUser> createState() => _CardRecipeUserState();
}

class _CardRecipeUserState extends State<CardRecipeUser> {
  Future<void> _clickdelete() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: GlobalProgress(),
        );
      },
    );

    DTOresponse response =
        await widget.recipeController.deleteRecipe(widget.recipe);
    Navigator.of(context).pop();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green, content: Text(response.message)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(response.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalheRecipePage(recipe: widget.recipe),
            ));
      },
      child: Container(
        width: 200,
        height: 200,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: NetworkImage("$baseUrl/${widget.recipe.imageURL}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: _buildPopupMenuButton(),
                ),
              ],
            ),
            Text(
              widget.recipe.title!,
              style: black_text_normal_bold,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenuButton() {
    return PopupMenuButton<String>(
      color: primaryWhite,
      iconColor: primaryWhite,
      onSelected: (value) async {
        if (value == 'edit') {
          // Implementar a lógica para editar a receita
          print('Editar receita');
        } else if (value == 'delete') {
          // Implementar a lógica para apagar a receita
          print('Apagar receita');
          await _clickdelete();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Apagar'),
          ),
        ),
      ],
    );
  }
}

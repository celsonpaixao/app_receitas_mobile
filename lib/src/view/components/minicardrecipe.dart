import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/components/globlafavoritebutton.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/recipeModel.dart';
import '../styles/colores.dart';

class MiniCardRecipe extends StatefulWidget {
  const MiniCardRecipe({Key? key, required this.item}) : super(key: key);

  final RecipeModel item;

  @override
  State<MiniCardRecipe> createState() => _MiniCardRecipeState();
}

class _MiniCardRecipeState extends State<MiniCardRecipe> {
  late final TokenDecod tokenDecod;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    tokenDecod = Provider.of<TokenDecod>(context, listen: false);
    user = await tokenDecod.decodeUser();
    if (mounted) {
      setState(() {}); // Força a reconstrução do widget após carregar o usuário
    }
  }

  @override
  Widget build(BuildContext context) {
    final averageRating = widget.item.calculateAverageRating()?.toDouble();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheRecipePage(recipe: widget.item),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 200,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: primaryWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    width: 160,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: primaryAmber,
                      image: DecorationImage(
                        image: NetworkImage(
                          "$baseUrl/${widget.item.imageURL}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: user != null
                          ? GlobalFavoriteButton(
                            item: widget.item,
                              userId: user!.id!,
                              recipeId: widget.item.id!,
                            )
                          : SizedBox
                              .shrink(), // Oculta o botão se o usuário não estiver carregado
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(
                widget.item.title ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                widget.item.description ?? '',
                style: TextStyle(color: Colors.black54, fontSize: 11),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (averageRating != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      averageRating.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryGrey,
                      ),
                    ),
                    GlobalRating(
                      count: 1,
                      value: averageRating,
                      sizeStar: 25,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

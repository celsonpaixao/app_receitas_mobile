import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../model/recipeModel.dart';
import '../styles/colores.dart';

class MiniCardRecipe extends StatelessWidget {
  const MiniCardRecipe({
    super.key,
    required this.item,
  });

  final RecipeModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalheRecipePage(recipe: item),
            ));
      },
      child: Container(
        width: 200,
        height: 260,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: primaryWhite,
          boxShadow: [
            BoxShadow(
                color: Colors.black45, blurRadius: 5, offset: Offset(0, 2))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 170,
                height: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: primaryAmber,
                  image: DecorationImage(
                      image: NetworkImage(
                          "$baseUrl/api_receita/${item.imageURL!}"),
                      fit: BoxFit.cover),
                ),
              ),
              ListTile(
                title: Text(
                  item.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  item.description!,
                  style: TextStyle(color: Colors.black54, fontSize: 11),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    item.calculateAverageRating().toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryGrey,
                    ),
                  ),
                  GlobalRating(
                    count: 1,
                    value: item?.calculateAverageRating()?.toDouble() ?? 0,
                    sizeStar: 25,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

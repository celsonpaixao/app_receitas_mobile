import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:flutter/material.dart';

import '../../model/recipeModel.dart';
import '../styles/colores.dart';

class MiniCardRecipe extends StatelessWidget {
  const MiniCardRecipe({Key? key, required this.item}) : super(key: key);

  final RecipeModel item;

  @override
  Widget build(BuildContext context) {
    final averageRating = item.calculateAverageRating()?.toDouble();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheRecipePage(recipe: item),
          ),
        );
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 160,
                height: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: primaryAmber,
                  image: DecorationImage(
                    image: NetworkImage(
                      "$baseUrl/${item.imageURL}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                item.title ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                item.description ?? '',
                style: const TextStyle(color: Colors.black54, fontSize: 11),
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
                      averageRating.toString(),
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

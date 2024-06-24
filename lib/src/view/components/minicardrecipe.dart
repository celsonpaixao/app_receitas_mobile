import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:app_receitas_mobile/src/view/components/globlafavoritebutton.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';

class MiniCardRecipe extends StatefulWidget {
  final UserModel user;
  final RecipeModel item;
  final List<RatingModel> ratings;
  const MiniCardRecipe({
    super.key,
    required this.item,
    required this.ratings,
    required this.user,
  });

  @override
  State<MiniCardRecipe> createState() => _MiniCardRecipeState();
}

class _MiniCardRecipeState extends State<MiniCardRecipe> {
  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: DecorationImage(
                  image: NetworkImage("$baseUrl/${widget.item.imageURL}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GlobalFavoriteButton(
                    item: widget.item,
                    userId: widget.user.id!,
                    recipeId: widget.item.id!,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title ?? '',
                    style: black_text_sub_title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.description ?? '',
                    style: grey_text_small,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (widget.item.averageRating != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.item.averageRating!.toStringAsFixed(1),
                      style: grey_text_normal_bold,
                    ),
                    const SizedBox(width: 4),
                    GlobalRating(
                      count: 1, // Altere para o número correto de estrelas
                      value: widget.item.averageRating!,
                      sizeStar: 20,
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

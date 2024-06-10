
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GetRatingsForRecipe extends StatelessWidget {
  const GetRatingsForRecipe({
    super.key,
    required this.widget,
  });

  final DetalheRecipePage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.recipe.avaliacoes?.length ?? 0,
        (index) {
          var item = widget.recipe.avaliacoes?[index];
          return ListTile(
            title: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item?.user?.firstName ?? 'Nome não disponível'} ${item?.user?.lastName ?? 'Sobrenome não disponível'}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RatingBar.builder(
                  initialRating: item?.value?.toDouble() ?? 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // Handle rating update
                  },
                ),
              ],
            ),
            subtitle: Text(item?.message ?? ""),
          );
        },
      ),
    );
  }
}

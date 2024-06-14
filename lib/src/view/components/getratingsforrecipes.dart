
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:flutter/material.dart';

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
               GlobalRating(count: 5, value: item?.value?.toDouble() ?? 0, sizeStar: 25)
              ],
            ),
            subtitle: Text(item?.message ?? ""),
          );
        },
      ),
    );
  }
}

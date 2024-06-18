import 'package:app_receitas_mobile/src/controller/ratingController.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetRatingsForRecipe extends StatefulWidget {
  const GetRatingsForRecipe({
    super.key,
    required this.widget,
  });

  final DetalheRecipePage widget;

  @override
  State<GetRatingsForRecipe> createState() => _GetRatingsForRecipeState();
}

class _GetRatingsForRecipeState extends State<GetRatingsForRecipe> {
  late RatingController ratins;
  @override
  Widget build(BuildContext context) {
    ratins = context.watch<RatingController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.widget.recipe.avaliacoes?.length ?? 0,
        (index) {
          var item = widget.widget.recipe.avaliacoes?[index];
          return ListTile(
            shape: Border(bottom: BorderSide(color: primaryGrey)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${item?.user?.firstName ?? 'Nome não disponível'} ${item?.user?.lastName ?? 'Sobrenome não disponível'}",
                    style: black_text_normal_bold),
                GlobalRating(
                    count: 5, value: item?.value?.toDouble() ?? 0, sizeStar: 25)
              ],
            ),
            subtitle: Text(item?.message ?? ""),
          );
        },
      ),
    );
  }
}
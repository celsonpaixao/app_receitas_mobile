import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class GetMaterialsRecipeDeteilhs extends StatelessWidget {
  const GetMaterialsRecipeDeteilhs({
    super.key,
    required this.widget,
  });

  final DetalheRecipePage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.recipe.materials?.length ?? 0,
        (index) {
          var item = widget.recipe.materials?[index];
          return Text(
            item ?? 'Material não disponível',
            style: TextStyle(
              color: primaryGrey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          );
        },
      ),
    );
  }
}

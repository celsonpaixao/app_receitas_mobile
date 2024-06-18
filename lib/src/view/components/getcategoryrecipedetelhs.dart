import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';

class GetCategoryRecipeDetalhes extends StatelessWidget {
  const GetCategoryRecipeDetalhes({
    super.key,
    required this.widget,
  });

  final DetalheRecipePage widget;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, // Espaçamento horizontal entre os itens
      runSpacing: 8, // Espaçamento vertical entre as linhas
      children: List.generate(
        widget.recipe.categorias?.length ?? 0,
        (index) {
          var item = widget.recipe.categorias?[index];
          return Container(
            decoration: BoxDecoration(
              color: primaryAmber,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(
                item ?? 'Categoria não disponível',
                style: white_text_normal_bold,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}

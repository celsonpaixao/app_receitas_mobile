import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
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
            width: (MediaQuery.of(context).size.width - 48) /
                3, // 3 items por linha com espaçamento
            decoration: BoxDecoration(
              color: primaryAmber,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(
                item ?? 'Categoria não disponível',
                style: TextStyle(
                  color: primaryWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
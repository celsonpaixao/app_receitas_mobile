import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/view/components/globalbaclbutton.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class DetalheRecipePage extends StatefulWidget {
  final RecipeModel recipe;
  const DetalheRecipePage({super.key, required this.recipe});

  @override
  State<DetalheRecipePage> createState() => _DetalheRecipePageState();
}

class _DetalheRecipePageState extends State<DetalheRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                color: primaryAmber,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Globalbackbutton(),
                  ),
                ),
              ),
              Expanded(
                child: LayoutPage(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacing(value: 0.02),
                      Text(
                        widget.recipe.description!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Spacing(value: 0.02),
                      // Adicione mais widgets aqui conforme necessário
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 190,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Spacing(value: 0.02),
                    Text(
                      widget.recipe.description!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    // Adicione mais detalhes aqui conforme necessário
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

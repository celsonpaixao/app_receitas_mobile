import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:app_receitas_mobile/src/view/components/minicardrecipe.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

import '../../model/recipeModel.dart';

class TabViewAllRecipe extends StatefulWidget {
  const TabViewAllRecipe({super.key});

  @override
  State<TabViewAllRecipe> createState() => _TabViewAllRecipeState();
}

class _TabViewAllRecipeState extends State<TabViewAllRecipe>
    with SingleTickerProviderStateMixin {
  List<RecipeModel> recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipe();
  }

  void _loadRecipe() async {
    List<RecipeModel> getRecipes = await RecipeController().getRecipeAll();
    setState(() {
      recipes = getRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: recipes.isEmpty
          ? MiniCardRecipeShimmer()
          : Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  var item = recipes[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: MiniCardRecipe(item: item),
                  );
                },
              ),
            ),
    );
  }
}

class MiniCardRecipeShimmer extends StatelessWidget {
  const MiniCardRecipeShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GlobalShimmer(
            shimmerWidth: 200,
            shimmerHeight: 60,
            border: 8,
          ),
        );
      },
    );
  }
}

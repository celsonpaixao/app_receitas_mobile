import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/view/components/globalprogress.dart';
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
        backgroundColor: primaryWite,
        body: recipes.isEmpty
            ? MiniCardRecipeShimmer()
            : Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    var item = recipes[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: MiniCardRecipe(item: item),
                    );
                  },
                ),
              ));
  }
}

class MiniCardRecipeShimmer extends StatelessWidget {
  const MiniCardRecipeShimmer({
    
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalShimmer(
      direction: Axis.horizontal,
      acount: 5,
      shimmer_width: 200,
      shimmer_heigth: 60,
      horizontal_padding: 16,
      vertical_padding: 10,
      border: 8,
    );
  }
}

import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:app_receitas_mobile/src/view/components/minicardrecipe.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

import '../../controller/recipeController.dart';
import '../../model/recipeModel.dart';

class TabViewRecipeByCategory extends StatefulWidget {
  final int id_category;
  const TabViewRecipeByCategory({super.key, required this.id_category});

  @override
  State<TabViewRecipeByCategory> createState() =>
      _TabViewRecipeByCategoryState();
}

class _TabViewRecipeByCategoryState extends State<TabViewRecipeByCategory> {
  List<RecipeModel> recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipe();
  }

  void _loadRecipe() async {
    List<RecipeModel> getRecipes =
        await RecipeController().getRecipeByCategory(widget.id_category);
    setState(() {
      recipes = getRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: recipes.isEmpty
          ? GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 5,
                  childAspectRatio: .70),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: GlobalShimmer(
                    shimmerWidth: 190,
                    shimmerHeight: 100,
                    border: 8,
                  ),
                );
              },
            )
          : GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: recipes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 5,
                  childAspectRatio: .70),
              itemBuilder: (context, index) {
                var item = recipes[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: MiniCardRecipe(item: item),
                );
              },
            ),
    );
  }
}

import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/view/components/globalprogress.dart';
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
            ? Center(child: GlobalProgress())
            : Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    var item = recipes[index];
                   
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: MiniCardRecipe(item: item),
                    );
                  },
                ),
            ));
  }
}


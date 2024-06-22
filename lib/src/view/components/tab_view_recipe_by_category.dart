import 'package:app_receitas_mobile/src/view/components/minicardrecipe.dart';
import 'package:app_receitas_mobile/src/view/components/minicardshimmer.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/ratingController.dart';
import '../../controller/recipeController.dart';

class TabViewRecipeByCategory extends StatefulWidget {
  final int idCategory;
  final String name;

  const TabViewRecipeByCategory({
    Key? key,
    required this.idCategory,
    required this.name,
  }) : super(key: key);

  @override
  _TabViewRecipeByCategoryState createState() =>
      _TabViewRecipeByCategoryState();
}

class _TabViewRecipeByCategoryState extends State<TabViewRecipeByCategory> {
  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  void _fetchRecipes() {
    final recipeController =
        Provider.of<RecipeController>(context, listen: false);
    recipeController.getRecipeByCategory(widget.idCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: Consumer<RecipeController>(
        builder: (context, recipe, child) {
          final ratings = Provider.of<RatingController>(context, listen: false);
          return recipe.isLoadbyCategory
              ? GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 5,
                    childAspectRatio: .65,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 10,
                      ),
                      child: MiniCardRecipeShimmer(),
                    );
                  },
                )
              : recipe.listRecipebyCategory.isEmpty
                  ? Center(
                      child: Text(
                        "Não foi encontrada nenhuma receita da categoria ${widget.name}",
                        textAlign: TextAlign.center,
                        style: black_text_normal,
                      ),
                    )
                  : GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: recipe.listRecipebyCategory.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 5,
                        childAspectRatio: .65,
                      ),
                      itemBuilder: (context, index) {
                        var item = recipe.listRecipebyCategory[index];
                        ratings.getRatingByRecipe(item.id!);
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                            right: 5,
                            top: 5
                          ),
                          child: MiniCardRecipe(
                            item: item,
                            ratings: ratings.listRating,
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}

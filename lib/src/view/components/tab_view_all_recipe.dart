import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/view/components/minicardrecipe.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:app_receitas_mobile/src/controller/ratingController.dart';
import 'minicardshimmer.dart';

class TabViewAllRecipe extends StatefulWidget {
  final UserModel user;
  const TabViewAllRecipe({Key? key, required this.user}) : super(key: key);

  @override
  State<TabViewAllRecipe> createState() => _TabViewAllRecipeState();
}

class _TabViewAllRecipeState extends State<TabViewAllRecipe>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Fetch recipes initially
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final recipes = Provider.of<RecipeController>(context, listen: false);
      recipes.getRecipeAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: Consumer<RecipeController>(
        builder: (context, recipes, child) {
          final ratings = Provider.of<RatingController>(context, listen: false);
          return recipes.isLoadAllList
              ? ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MiniCardRecipeShimmer(),
                  ),
                )
              : recipes.listAllRecipe.isEmpty
                  ? Center(
                      child: Text(
                        "Nenhuma receita encontrada...!",
                        style: black_text_normal,
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recipes.listAllRecipe.length,
                      itemBuilder: (context, index) {
                        var item = recipes.listAllRecipe[
                            recipes.listAllRecipe.length - 1 - index];
                        ratings.getRatingByRecipe(item.id!);
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: MiniCardRecipe(
                            user: widget.user,
                            item: item,
                            ratings: ratings.getRatingsForRecipe(widget.user.id!),
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}

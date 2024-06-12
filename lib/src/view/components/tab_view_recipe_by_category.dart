import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:app_receitas_mobile/src/view/components/minicardrecipe.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../controller/recipeController.dart';
import '../../model/recipeModel.dart';

class TabViewRecipeByCategory extends StatefulWidget {
  final int idCategory;

  const TabViewRecipeByCategory({Key? key, required this.idCategory})
      : super(key: key);

  @override
  _TabViewRecipeByCategoryState createState() =>
      _TabViewRecipeByCategoryState();
}

class _TabViewRecipeByCategoryState extends State<TabViewRecipeByCategory> {
  List<RecipeModel> recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final getRecipes =
        await RecipeController().getRecipeByCategory(widget.idCategory);
    setState(() {
      recipes = getRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: recipes.isEmpty ? 6 : recipes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 5,
          childAspectRatio:
              MediaQuery.of(context).size.height <= 1080 ? .75 : .65,
        ),
        itemBuilder: (context, index) {
          if (recipes.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              child: GlobalShimmer(
                shimmerWidth: 190,
                shimmerHeight: 100,
                border: 8,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              child: MiniCardRecipe(item: recipes[index]),
            );
          }
        },
      ),
    );
  }
}

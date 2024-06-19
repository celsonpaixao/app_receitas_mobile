import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/components/globalsearchinput.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/shimmerlist.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/ratingController.dart';
import '../../model/ratingModel.dart';
import '../../utils/api/apicontext.dart';

class ListRecipePage extends StatefulWidget {
  const ListRecipePage({Key? key}) : super(key: key);

  @override
  State<ListRecipePage> createState() => _ListRecipePageState();
}

class _ListRecipePageState extends State<ListRecipePage> {
  List<RecipeModel> recipes = [];
  List<RecipeModel> filteredRecipes = [];
  TextEditingController searchController = TextEditingController();
  late RecipeController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<RecipeController>(context, listen: false);
    // Fetch recipes initially
    controller.getRecipeAll().then((_) {
      setState(() {
        recipes = controller.listAllRecipe.toList();
        filteredRecipes = recipes;
      });
    });
    searchController.addListener(_filterRecipes);
  }

  void _filterRecipes() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredRecipes = recipes
          .where(
            (recipe) =>
                recipe.title!.toLowerCase().contains(query) ||
                recipe.description!.toLowerCase().contains(query),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterRecipes);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: GlobalSearchInput(
          controller: searchController,
        ),
        height: 100,
      ),
      body: LayoutPage(
        body: Consumer<RecipeController>(
          builder: (context, controller, child) {
                      final ratigs =
                Provider.of<RatingController>(context, listen: false);
            final RatingModel ratingModel = RatingModel();
            if (controller.isLoadAllList) {
              return ShimmerList();
            } else if (filteredRecipes.isEmpty) {
              return Center(
                child: Text(
                  "Nenhuma receita encontrada...!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  var item = filteredRecipes[index];
                   ratigs.getRatingByRecipe(item.id!);
                  final averageRating = ratingModel
                      .calculateAverageRating(ratigs.listRating)
                      ?.toDouble();
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetalheRecipePage(recipe: item),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: primaryAmber,
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "$baseUrl/${item.imageURL}",
                                    )),
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (averageRating != null)
                                  GlobalRating(
                                    count: 5,
                                    value: averageRating,
                                    sizeStar: 15,
                                  ),
                              ],
                            ),
                            subtitle: Text(
                              item.description!,
                              style: TextStyle(color: primaryGrey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

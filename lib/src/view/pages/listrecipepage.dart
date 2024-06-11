import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/view/components/globalsearchinput.dart';
import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/recipeController.dart';
import '../../model/recipeModel.dart';
import '../components/globalrating.dart';

class ListRecipePage extends StatefulWidget {
  const ListRecipePage({super.key});

  @override
  State<ListRecipePage> createState() => _ListRecipePageState();
}

class _ListRecipePageState extends State<ListRecipePage> {
  List<RecipeModel> recipes = [];
  List<RecipeModel> filteredRecipes = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecipe();
    searchController.addListener(_filterRecipes);
  }

  void _loadRecipe() async {
    List<RecipeModel> getRecipes = await RecipeController().getRecipeAll();
    setState(() {
      recipes = getRecipes;
      filteredRecipes = getRecipes;
    });
  }

  void _filterRecipes() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredRecipes = recipes
          .where((recipe) =>
              recipe.title!.toLowerCase().contains(query) ||
              recipe.description!.toLowerCase().contains(query))
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
      appBar: AppBar(
        backgroundColor: primaryAmber,
        toolbarHeight: 100,
        leadingWidth: 25,
        automaticallyImplyLeading: false,
        title: GlobalSearchInput(
          controller: searchController,
        ),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: LayoutPage(
        body: filteredRecipes.isEmpty
            ? ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: GlobalShimmer(
                      shimmerWidth: double.infinity,
                      shimmerHeight: 80,
                      border: 8,
                    ),
                  );
                },
              )
            : ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  var item = filteredRecipes[index];
                  final averageRating =
                      item.calculateAverageRating()?.toDouble();
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
                                image: DecorationImage(image: NetworkImage("$baseUrl/${item.imageURL}"))
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
              ),
      ),
    );
  }
}

import 'package:app_receitas_mobile/src/controller/favoriteController.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/globalsearchinput.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/recipeModel.dart';
import '../../utils/api/apicontext.dart';
import '../components/globalrating.dart';
import '../components/globalshimmer.dart';
import '../components/layoutpage.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoriteController controller;
  List<RecipeModel> recipes = [];
  List<RecipeModel> filteredRecipes = [];
  TextEditingController searchController = TextEditingController();
  @override
  @override
  void initState() {
    super.initState();
    controller = Get.find<FavoriteController>();
    controller.getFavoritesRecipe(7);
    _loadRecipe();
    searchController.addListener(_filterRecipes);
  }

  void _loadRecipe() async {
    List<RecipeModel> getRecipes = await controller.listfavorite;
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GlobalAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Seus Favoritos",
                style: TextStyle(
                  color: primaryWhite,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GlobalSearchInput(
                controller: searchController,
              )
            ],
          ),
          height: 100,
        ),
        body: Obx(
          () {
            return LayoutPage(
              body: controller.isLoading.value
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
                  : controller.listfavorite.isEmpty
                      ? Text("Você não tem nenhuma receita favoritada!")
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
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "$baseUrl/${item.imageURL}"))),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
            );
          },
        ));
  }
}

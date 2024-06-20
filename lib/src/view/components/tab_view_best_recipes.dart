import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../controller/ratingController.dart';
import '../../model/ratingModel.dart';

class TabViewBestRecipe extends StatefulWidget {
  const TabViewBestRecipe({Key? key}) : super(key: key);

  @override
  State<TabViewBestRecipe> createState() => _TabViewBestRecipeState();
}

class _TabViewBestRecipeState extends State<TabViewBestRecipe>
    with SingleTickerProviderStateMixin {
  late RecipeController recipeController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      recipeController = Provider.of<RecipeController>(context, listen: false);
      recipeController.filterBestReceipe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeController>(
      builder: (context, recipes, child) {
        final ratings = Provider.of<RatingController>(context, listen: false);
        return Container(
          child: recipes.isLoadbestRecipe
              ? PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => GlobalShimmer(
                    shimmerWidth: MediaQuery.of(context).size.width,
                    shimmerHeight: 80,
                    border: 8,
                  ),
                )
              : recipes.listbestReceipe.isEmpty
                  ? null
                  : Expanded(
                      child: PageView.builder(
                        itemCount: recipes.listbestReceipe.length,
                        itemBuilder: (context, index) {
                          var item = recipes.listbestReceipe[index];
                          ratings.getRatingByRecipe(item.id!);
                          final ratingModel = RatingModel();
                          var value = ratingModel
                              .calculateAverageRating(ratings.listRating);
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                              color: primaryAmber,
                              borderRadius: BorderRadius.circular(8.7),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage("$baseUrl/${item.imageURL!}"),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child: GlobalRating(
                                    count: 5,
                                    value: value != null
                                        ? value
                                        : 0,
                                    sizeStar: 20,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 5,
                                  child: Text(
                                    item.title!,
                                    style: white_text_subtitle,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}

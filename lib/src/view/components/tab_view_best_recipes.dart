import 'dart:async';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/controller/ratingController.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/api/apicontext.dart';
import '../styles/texts.dart';

class TabViewBestRecipe extends StatefulWidget {
  const TabViewBestRecipe({Key? key}) : super(key: key);

  @override
  State<TabViewBestRecipe> createState() => _TabViewBestRecipeState();
}

class _TabViewBestRecipeState extends State<TabViewBestRecipe> {
  late RecipeController recipeController;
  late RatingController ratingController;
  late PageController pageController;
  Timer? timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    recipeController = Provider.of<RecipeController>(context, listen: false);
    ratingController = Provider.of<RatingController>(context, listen: false);
    recipeController.filterBestReceipe();

    pageController = PageController(initialPage: 0);

    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      if (_currentIndex == recipeController.listbestReceipe.length - 1) {
        _currentIndex = 0;
      } else {
        _currentIndex++;
      }
      pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeController>(
      builder: (context, recipeController, child) {
        return recipeController.isLoadbestRecipe
            ? GlobalShimmer(
                shimmerWidth: MediaQuery.of(context).size.width,
                shimmerHeight: 80,
                border: 8,
              )
            : recipeController.listbestReceipe.isEmpty
                ? const Center(
                    child: Text('Nenhuma receita encontrada.'),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: recipeController.listbestReceipe.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            var item = recipeController.listbestReceipe[index];
                            var averageRating = item.averageRating ?? 0;
                            return GestureDetector(
                              onTap: () {
                                // Implement onTap functionality if needed
                              },
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  color: primaryAmber,
                                  borderRadius: BorderRadius.circular(8.7),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "$baseUrl/${item.imageURL!}"),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: 0,
                                      child: GlobalRating(
                                        count: 5,
                                        value: averageRating,
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
                              ),
                            );
                          },
                        ),
                      ),
                     const Spacing(value: .01),
                     SmoothPageIndicator(
                           controller: pageController,
                           count: recipeController.listbestReceipe.length,
                           effect: WormEffect(
                             dotWidth: 10,
                             dotHeight: 10,
                             activeDotColor: primaryAmber,
                             dotColor: secundaryGrey,
                           ),
                         )
                    ],
                  );
      },
    );
  }
}

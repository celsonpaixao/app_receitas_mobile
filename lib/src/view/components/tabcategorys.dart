import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/components/tab_view_best_recipes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/categoryController.dart';

import '../../model/categoryModel.dart';
import '../components/tab_view_all_recipe.dart';
import '../components/tab_view_recipe_by_category.dart';
import '../components/globalprogress.dart';
import '../components/layoutpage.dart';
import '../pages/listrecipepage.dart';
import '../styles/colores.dart';
import '../styles/texts.dart';

class TabCategory extends StatefulWidget {
  final UserModel user;
  const TabCategory({super.key, required this.user});

  @override
  State<TabCategory> createState() => _TabCategoryState();
}

class _TabCategoryState extends State<TabCategory>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController
    _tabController =
        TabController(length: 0, vsync: this); // Start with length 0

    // Fetch categories initially
    final categoryController = context.read<CategoryController>();
    categoryController.getCategoryList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, categoryController, child) {
        // Get the number of categories
        final categories = categoryController.listCategories;

        // Clone the original list to a new mutable list
        List<CategoryModel> modifiedCategories = List.from(categories);

        // Add "Todos" category if it's not already present
        if (!categories.any((category) => category.name == "Todos")) {
          modifiedCategories.insert(0, CategoryModel(id: 0, name: "Todos"));
        }

        // Update TabController length when categories change
        if (_tabController.length != modifiedCategories.length) {
          _tabController =
              TabController(length: modifiedCategories.length, vsync: this);
        }

        return LayoutPage(
          body: Column(
            children: [
              Material(
                color: primaryWhite,
                child: categoryController.isLoading
                    ? const GlobalProgress()
                    : categoryController.listCategories.isNotEmpty
                        ? TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            physics: const ClampingScrollPhysics(),
                            unselectedLabelColor: secundaryAmber,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: primaryAmber,
                            labelColor: primaryAmber,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                            tabs: modifiedCategories
                                .map((category) => Tab(text: category.name!))
                                .toList(),
                          )
                        : Center(
                            child: Text(
                              "Nenhuma categoria encontrada.",
                              style: black_text_normal,
                            ),
                          ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: modifiedCategories.map((category) {
                    if (category.name == "Todos") {
                      return Scaffold(
                        body: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacing(value: .02),
                              Text(
                                "Receitas  mais bem avaliadas...",
                                style: grey_text_subtitle,
                              ),
                              const Spacing(value: .02),
                              const SizedBox(
                                height: 200,
                                child: TabViewBestRecipe(),
                              ),
                              const Spacing(value: .01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Receitas recentes",
                                    style: grey_text_subtitle,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ListRecipePage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Ver mais",
                                      style: TextStyle(
                                        color: primaryGrey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacing(value: .02),
                              SizedBox(
                                height: 260,
                                child: TabViewAllRecipe(
                                  user: widget.user,
                                ),
                              ),
                              const Spacing(value: .1),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return TabViewRecipeByCategory(
                        user: widget.user,
                        name: category.name!,
                        idCategory: category.id!,
                      );
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

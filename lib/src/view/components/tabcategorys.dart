import 'package:app_receitas_mobile/src/controller/categoryController.dart';
import 'package:app_receitas_mobile/src/view/components/tab_view_all_recipe.dart';
import 'package:app_receitas_mobile/src/view/components/tab_view_recipe_by_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/listrecipepage.dart';
import '../styles/colores.dart';
import '../components/globalprogress.dart';
import '../components/layoutpage.dart';

class TabCategory extends StatefulWidget {
  const TabCategory({Key? key}) : super(key: key);

  @override
  State<TabCategory> createState() => _TabCategoryState();
}

class _TabCategoryState extends State<TabCategory>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Fetch categories initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categories =
          Provider.of<CategoryController>(context, listen: false);
      categories.getCategoryList().then((_) {
        _initializeTabController(categories.listCategories.length);
      });
    });
  }

  void _initializeTabController(int length) {
    _tabController = TabController(length: length, vsync: this);
    setState(() {});
  }

  void _updateTabController(int length) {
    if (_tabController?.length != length) {
      _tabController?.dispose();
      _tabController = TabController(length: length, vsync: this);
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final categories = Provider.of<CategoryController>(context);
    _updateTabController(categories.listCategories.length);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, categories, child) {
        if (_tabController == null) {
          _initializeTabController(categories.listCategories.length);
        }
        return LayoutPage(
          body: Column(
            children: [
              Material(
                color: primaryWhite,
                child: categories.listCategories.isNotEmpty
                    ? TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        physics: ClampingScrollPhysics(),
                        unselectedLabelColor: secundaryAmber,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: primaryAmber,
                        labelColor: primaryAmber,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        tabs: categories.listCategories
                            .map((category) => Tab(text: category.name!))
                            .toList(),
                      )
                    : null,
              ),
              Expanded(
                child: categories.isLoading
                    ? Center(child: GlobalProgress())
                    : categories.listCategories.isEmpty
                        ? Text("Nenhuma categoria encontrada.")
                        : TabBarView(
                            controller: _tabController,
                            children: categories.listCategories.map((category) {
                              if (category.name == "Todos") {
                                return Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Receitas recentes",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        ListRecipePage(),
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
                                      ),
                                      SizedBox(
                                        height: 270,
                                        child: TabViewAllRecipe(),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return TabViewRecipeByCategory(
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

  @override
  void dispose() {
    _tabController?.dispose(); // Dispose of the TabController
    super.dispose();
  }
}

import 'package:app_receitas_mobile/src/controller/categoryController.dart';
import 'package:app_receitas_mobile/src/view/components/tab_view_all_recipe.dart';
import 'package:flutter/material.dart';
import '../../model/categoryModel.dart';
import '../styles/colores.dart';
import '../components/globalprogress.dart';
import '../components/layoutpage.dart';

class TabCategory extends StatefulWidget {
  const TabCategory({Key? key}) : super(key: key);

  @override
  State<TabCategory> createState() => _TabCategoryState();
}

class _TabCategoryState extends State<TabCategory>
    with SingleTickerProviderStateMixin {
  List<CategoryModel> categories = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  void _loadCategory() async {
    List<CategoryModel> getCategories =
        await CategoryController().getCategoryList();
    setState(() {
      categories = getCategories;
      _tabController =
          TabController(length: categories.length + 1, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      body: Column(
        children: [
          Material(
            color: primaryWite,
            child: categories.isNotEmpty
                ? TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    physics: ClampingScrollPhysics(),
                    tabAlignment: TabAlignment.start,
                    unselectedLabelColor: secundaryAmber,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: primaryAmber,
                    labelColor: primaryAmber,
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                    tabs: [
                      Tab(text: "Todos"),
                      ...categories
                          .map((category) => Tab(text: category.name!))
                          .toList(),
                    ],
                  )
                : null,
          ),
          Expanded(
            child: categories.isNotEmpty
                ? TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 280,
                                child: TabViewAllRecipe(),
                              ),
                            ],
                          )),
                      ...categories
                          .map((category) => Container(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Conteúdo da categoria: ${category.name}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ))
                          .toList(),
                    ],
                  )
                : Center(child: GlobalProgress()),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

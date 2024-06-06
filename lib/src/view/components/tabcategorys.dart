import 'package:app_receitas_mobile/src/view/components/globalprogress.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import '../../model/categoryModel.dart';
import '../../repository/categoryRepository.dart';

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
        await CategoryRepository().getCategorys();
    setState(() {
      categories = getCategories;
      _tabController = TabController(length: categories.length, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 15,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        bottom: categories.isNotEmpty
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
                tabs: categories
                    .map((category) => Tab(
                          text: category.name!,
                        ))
                    .toList(),
              )
            : null,
      ),
      body: LayoutPage(
        body: categories.isNotEmpty
            ? TabBarView(
                controller: _tabController,
                children: categories
                    .map((category) => Container(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Conteúdo da categoria: ${category.name}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ))
                    .toList(),
              )
            : Center(child: GlobalProgress()),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

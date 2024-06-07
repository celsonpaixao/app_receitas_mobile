import 'package:app_receitas_mobile/src/view/pages/favoritespage.dart';
import 'package:app_receitas_mobile/src/view/pages/homepage.dart';
import 'package:app_receitas_mobile/src/view/pages/listrecipepage.dart';
import 'package:app_receitas_mobile/src/view/pages/profilepage.dart';
import 'package:flutter/material.dart';

import 'components/buttonaddrecipe.dart';
import 'styles/colores.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({super.key});

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  int currentTab = 0;
  final pages = [HomePage(), ListRecipePage(), FavoritesPage(), ProfilePage()];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage = HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentPage),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: primaryWite,
        elevation: 0,
        // shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                minWidth: 40,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    currentPage = HomePage();
                    currentTab = 0;
                  });
                },
                child: Icon(
                  Icons.home_rounded,
                  color: currentTab == 0 ? primaryAmber : Colors.black26,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    currentPage = ListRecipePage();
                    currentTab = 1;
                  });
                },
                child: Icon(
                  Icons.list_rounded,
                  color: currentTab == 1 ? primaryAmber : Colors.black26,
                ),
              ),
              MaterialButton(
                minWidth: 50,
                height: 50,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                color: primaryAmber,
                shape: CircleBorder(),
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  color: primaryWite,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    currentPage = FavoritesPage();
                    currentTab = 3;
                  });
                },
                child: Icon(
                  Icons.favorite,
                  color: currentTab == 3 ? primaryAmber : Colors.black26,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    currentPage = ProfilePage();
                    currentTab = 4;
                  });
                },
                child: Icon(
                  Icons.person,
                  color: currentTab == 4 ? primaryAmber : Colors.black26,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

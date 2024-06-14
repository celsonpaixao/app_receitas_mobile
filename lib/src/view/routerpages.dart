import 'package:app_receitas_mobile/src/view/pages/favoritespage.dart';
import 'package:app_receitas_mobile/src/view/pages/homepage.dart';
import 'package:app_receitas_mobile/src/view/pages/listrecipepage.dart';
import 'package:app_receitas_mobile/src/view/pages/profilepage.dart';
import 'package:app_receitas_mobile/src/view/pages/sendrecipepgae.dart';
import 'package:flutter/material.dart';

import 'styles/colores.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({super.key});

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> pages = [
    HomePage(),
    ListRecipePage(),
    Container(), // Placeholder for the FAB
    FavoritesPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: IndexedStack(
          index: currentTab,
          children: pages,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        color: primaryAmber,
        elevation: 0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(icon: Icons.home_rounded, index: 0),
              _buildTabItem(icon: Icons.list_rounded, index: 1),

              MaterialButton(
                color: primaryWhite,
                elevation: 0,
                shape: CircleBorder(),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SendRecipePage(),
                      ));
                },
                child: Icon(
                  Icons.add,
                  color: primaryAmber,
                ),
              ),
              // Space for the floating action button
              _buildTabItem(icon: Icons.favorite, index: 3),
              _buildTabItem(icon: Icons.person, index: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({required IconData icon, required int index}) {
    return IconButton(
      onPressed: () {
        setState(() {
          currentTab = index;
        });
      },
      icon: Icon(
        icon,
        color: currentTab == index ? primaryWhite : Colors.black26,
      ),
    );
  }
}

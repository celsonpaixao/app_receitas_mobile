import 'package:app_receitas_mobile/src/controller/favoriteController.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/components/globalsearchinput.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/api/apicontext.dart';
import '../components/shimmerlist.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoriteController favorites;
 late UserModel user;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUser();
   favorites.getFavoritesRecipe(user.id!);
  }

  Future<void> _loadUser() async {
    try {
      final tokenController = Provider.of<TokenDecod>(context, listen: false);
      final decodedUser = await tokenController.decodeUser();
      setState(() {
        user = decodedUser;
      });
    } catch (e) {
      print('Error loading user: $e');
    }
  }

@override
  Widget build(BuildContext context) {
    // Ensure favorites is initialized via context.watch
    favorites = context.watch<FavoriteController>();

    // // Check if favorites is null before using its properties
    // if (favorites.listFavorite.isEmpty) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text("Carregando..."),
    //     ),
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }

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
            GlobalSearchInput(),
          ],
        ),
        height: 100,
      ),
      body: LayoutPage(
        body: favorites.isLoading
            ? ShimmerList()
            : favorites.listFavorite.isEmpty
                ? Center(
                    child: Text("Sem Favoritos..."),
                  )
                : ListView.builder(
                    itemCount: favorites.listFavorite.length,
                    itemBuilder: (context, index) {
                      var item = favorites.listFavorite[index];
                      final averageRating =
                          item.calculateAverageRating()?.toDouble();
                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: primaryAmber,
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "$baseUrl/${item.imageURL}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
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
                          Divider(),
                        ],
                      );
                    },
                  ),
      ),
    );
  }

}


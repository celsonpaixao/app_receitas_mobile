import 'package:app_receitas_mobile/src/view/components/shimmerlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_receitas_mobile/src/controller/favoriteController.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/components/globalsearchinput.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import '../../utils/api/apicontext.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoriteController favorites;
  late UserModel user;
  late String searchText = '';

  @override
  void initState() {
    super.initState();
    favorites = Provider.of<FavoriteController>(context, listen: false);
    initializeData();
  }

  Future<void> initializeData() async {
    user = await TokenDecod().decodeUser();
    await favorites.getFavoritesRecipe(user.id!);
  }

  @override
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
              onchange: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ],
        ),
        height: 100,
      ),
      body: Consumer<FavoriteController>(
        builder: (context, favoriteController, child) {
          return LayoutPage(
            body: favoriteController.isLoading
                ? ShimmerList()
                : favoriteController.listFavorite.isEmpty
                    ? Center(
                        child: Text("Sem Favoritos..."),
                      )
                    : ListView.builder(
                        itemCount: favoriteController.listFavorite.length,
                        itemBuilder: (context, index) {
                          var item = favoriteController.listFavorite[index];
                          final averageRating =
                              item.calculateAverageRating()?.toDouble();

                          // Aplicar filtro
                          if (searchText.isNotEmpty &&
                              !item.title!
                                  .toLowerCase()
                                  .contains(searchText.toLowerCase())) {
                            return Container(); // Retorna um container vazio se o título não contém o texto de pesquisa
                          }

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
                              Divider(),
                            ],
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}

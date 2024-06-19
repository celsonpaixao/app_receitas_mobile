import 'package:app_receitas_mobile/src/controller/ratingController.dart';
import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/view/components/shimmerlist.dart';
import 'package:app_receitas_mobile/src/view/pages/detalhe_recipepage.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
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
  UserModel? user;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    favorites = Provider.of<FavoriteController>(context, listen: false);
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      user = await TokenDecod().decodeUser();
      if (user?.id != null) {
        await favorites.getFavoritesRecipe(user!.id!);
      }
    } catch (e) {
      print('Error initializing data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Seus Favoritos", style: white_text_title),
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
          final ratigs = Provider.of<RatingController>(context, listen: false);
          final RatingModel ratingModel = RatingModel();
          return LayoutPage(
            body: favoriteController.isLoading
                ? ShimmerList()
                : favoriteController.listFavorite.isEmpty
                    ? Center(
                        child: Text("Sem Favoritos..."),
                      )
                    : RefreshIndicator(
                        color: primaryAmber,
                        onRefresh: () async {
                          await favoriteController
                              .getFavoritesRecipe(user!.id!);
                        },
                        child: ListView.builder(
                          itemCount: favoriteController.listFavorite.length,
                          itemBuilder: (context, index) {
                            var item = favoriteController.listFavorite[index];
                            ratigs.getRatingByRecipe(item.id!);
                            final averageRating = ratingModel
                                .calculateAverageRating(ratigs.listRating)
                                ?.toDouble();

                            if (searchText.isNotEmpty &&
                                !item.title!
                                    .toLowerCase()
                                    .contains(searchText.toLowerCase())) {
                              return SizedBox.shrink();
                            }

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetalheRecipePage(recipe: item),
                                        ));
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: primaryAmber,
                                        borderRadius: BorderRadius.circular(6),
                                        image: item.imageURL != null
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                  "$baseUrl/${item.imageURL}",
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.title ?? 'Carregando....',
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
                                      item.description ?? 'Carregando...',
                                      style: TextStyle(color: primaryGrey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        ),
                      ),
          );
        },
      ),
    );
  }
}

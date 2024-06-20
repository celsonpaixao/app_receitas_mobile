import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_receitas_mobile/src/controller/ratingController.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/auth/tokendecod.dart';
import 'package:app_receitas_mobile/src/view/components/globalrating.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';

class GetRatingsForRecipe extends StatefulWidget {
  const GetRatingsForRecipe({
    Key? key,
    required this.recipeId,
  }) : super(key: key);

  final int recipeId;

  @override
  State<GetRatingsForRecipe> createState() => _GetRatingsForRecipeState();
}

class _GetRatingsForRecipeState extends State<GetRatingsForRecipe> {
  late Future<UserModel> _userFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RatingController>(context, listen: false)
          .getRatingByRecipe(widget.recipeId);
    });
    _userFuture = Provider.of<TokenDecod>(context, listen: false).decodeUser();
  }

  @override
  Widget build(BuildContext context) {
    final ratings = Provider.of<RatingController>(context);

    return FutureBuilder<UserModel>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          UserModel user = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              ratings.listRating.length,
              (index) {
                var item = ratings.listRating[index];
                final isAdmin = ratings.checkInAdmin(item.user!.id!, user.id!);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: secundaryGrey)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${item.user!.firstName} ${item.user!.lastName}",
                              style: black_text_normal_bold,
                            ),
                            GlobalRating(
                              count: 5,
                              value: item.value!.toDouble(),
                              sizeStar: 20,
                            ),
                          ],
                        ),
                        item.message!.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(item.message!),
                              )
                            : SizedBox.shrink(),
                        if (isAdmin) // Renderiza os botões apenas se o usuário for admin
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  await ratings.deleteRating(item.id!);
                                },
                                child: Text(
                                  "Deletar",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Implemente a lógica para edição aqui
                                  print("Editar avaliação");
                                },
                                child: Text(
                                  "Editar",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Text("Something went wrong");
        }
      },
    );
  }
}

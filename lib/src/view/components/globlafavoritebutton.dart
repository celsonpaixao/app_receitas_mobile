import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/favoriteController.dart';
import '../../model/recipeModel.dart';

class GlobalFavoriteButton extends StatefulWidget {
  const GlobalFavoriteButton({
    Key? key,
    required this.userId,
    required this.recipeId,
    required this.item,
  }) : super(key: key);

  final int userId;
  final int recipeId;
  final RecipeModel item;

  @override
  State<GlobalFavoriteButton> createState() => _GlobalFavoriteButtonState();
}

class _GlobalFavoriteButtonState extends State<GlobalFavoriteButton> {
  late FavoriteController controller;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    controller = context.read<FavoriteController>();
    isFavorite =
        controller.listFavorite.any((recipe) => recipe.id == widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    return controller.isLoading
        ? CircularProgressIndicator()
        : IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Colors.red,
            onPressed: () async {
              try {
                if (isFavorite) {
                  await controller.removeRecipeInFavorite(
                      widget.userId, widget.recipeId);
                } else {
                  await controller.addRecipeInFavorite(
                      widget.userId, widget.recipeId);
                }
                setState(() {
                  isFavorite = !isFavorite;
                });
              } catch (e) {
                print('Error toggling favorite status: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Failed to update favorite status: ${controller.errorMessage}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          );
  }
}

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
    // Obter a instância de FavoriteController usando Provider
    controller = context.read<FavoriteController>();
    // Verificar se a receita atual está na lista de favoritos ao inicializar o estado
    isFavorite =
        controller.listFavorite.any((recipe) => recipe.id == widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteController>(
      builder: (context, favoriteController, child) {
        // Atualizar isFavorite quando a lista de favoritos for alterada
        isFavorite = favoriteController.listFavorite
            .any((recipe) => recipe.id == widget.item.id);

        return favoriteController.isLoading
            ? CircularProgressIndicator() // Indicador de progresso enquanto estiver carregando
            : IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Colors.red,
                onPressed: () async {
                  try {
                    // Alterna o status de favorito ao pressionar o botão
                    if (isFavorite) {
                      await controller.removeRecipeInFavorite(
                          widget.userId, widget.recipeId, widget.item);
                    } else {
                      await controller.addRecipeInFavorite(
                        widget.userId,
                        widget.recipeId,
                        widget.item,
                      );
                    }
                    // Atualiza o estado local para refletir a mudança
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  } catch (e) {
                    // Lida com erros durante a alteração de status de favorito
                    print('Error toggling favorite status: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Failed to update favorite status: ${controller.errorMessage ?? "Unknown error"}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              );
      },
    );
  }
}

import 'package:app_receitas_mobile/src/controller/favoriteController.dart';
import 'package:flutter/material.dart';

class GlobalFavoriteButton extends StatefulWidget {
  final int userId;
  final int recipeId;

  const GlobalFavoriteButton({
    Key? key,
    required this.userId,
    required this.recipeId,
  }) : super(key: key);

  @override
  State<GlobalFavoriteButton> createState() => _GlobalFavoriteButtonState();
}

class _GlobalFavoriteButtonState extends State<GlobalFavoriteButton> {
  FavoriteController controller = FavoriteController();
  bool isFavorite = false;
  bool isAddingToFavorites = false;

  @override
  void initState() {
    super.initState();
    _checkIfRecipeIsFavorite();
  }

  void _checkIfRecipeIsFavorite() async {
    bool _isFavorite = await controller.checkInRecipe(widget.userId, widget.recipeId);
    setState(() {
      isFavorite = _isFavorite;
    });
  }

  void _toggleFavoriteStatus() async {
    if (isAddingToFavorites) return; // Evita múltiplas solicitações enquanto uma está em andamento
    setState(() {
      isAddingToFavorites = true;
    });
    
    try {
      if (isFavorite) {
        await controller.removeRecipeinFavorite(widget.userId, widget.recipeId);
      } else {
        await controller.addRecipeinFavorite(widget.userId, widget.recipeId);
      }
      setState(() {
        isFavorite = !isFavorite; // Alterna o status de favorito após a operação ser concluída com sucesso
      });
    } catch (e) {
      // Lidar com erros aqui, como exibir uma mensagem para o usuário
      print('Error: $e');
    } finally {
      setState(() {
        isAddingToFavorites = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFavoriteStatus,
      child: Container(
        child: isFavorite
            ? Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
              )
            : Icon(
                Icons.favorite_border,
                color: Colors.pinkAccent,
              ),
      ),
    );
  }
}

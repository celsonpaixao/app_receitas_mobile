import 'package:flutter/material.dart';

import '../../model/recipeModel.dart';
import '../styles/colores.dart';

class MiniCardRecipe extends StatelessWidget {
  const MiniCardRecipe({
    super.key,
    required this.item,
  });

  final RecipeModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 260,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: primaryWite,
          boxShadow: [
            BoxShadow(
                color: Colors.black45, blurRadius: 10, offset: Offset(0, 2))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 170,
            height: 125,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: primaryAmber,
                image: DecorationImage(
                    image: NetworkImage(
                      "https://static.itdg.com.br/images/1200-675/bd14ed0d98530fb34b6f60a295382a7a/348000-original.jpg",
                    ),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            title: Text(
              item.title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                
              ),
            ),
            subtitle: Text(
              item.description!,
              style: TextStyle(color: Colors.black54, fontSize: 11),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

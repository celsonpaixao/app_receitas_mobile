import 'package:app_receitas_mobile/src/view/pages/sendrecipepgae.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class ButtonAddRecipe extends StatelessWidget {
  const ButtonAddRecipe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: primaryAmber,
      shape: CircleBorder(),
      child: Icon(
        Icons.add,
        color: primaryWite,
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SendRecipePage(),
            ));
      },
    );
  }
}

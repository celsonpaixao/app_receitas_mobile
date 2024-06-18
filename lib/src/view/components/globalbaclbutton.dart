import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';


class Globalbackbutton extends StatelessWidget {
  const Globalbackbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Center(
        child: Icon(
          Icons.arrow_back_ios,
          color: primaryWhite,
        ),
      ),
    );
  }
}

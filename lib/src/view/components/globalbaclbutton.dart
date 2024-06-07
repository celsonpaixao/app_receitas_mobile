import 'package:flutter/material.dart';

import '../styles/colores.dart';

class Globalbackbutton extends StatelessWidget {
  const Globalbackbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        maximumSize: MaterialStatePropertyAll(Size(40, 40)),
        backgroundColor: MaterialStatePropertyAll(
          primaryWite.withOpacity(.5),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Center(
        child: Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }
}

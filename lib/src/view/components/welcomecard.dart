import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final String image;
  final String text;
  const WelcomeCard({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            image,
            width: 350,
            height: MediaQuery.of(context).size.height<= 1080? 300:  350,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: primaryWhite,
            ),
          ),
        ],
      ),
    );
  }
}

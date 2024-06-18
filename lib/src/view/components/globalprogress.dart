import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class GlobalProgress extends StatelessWidget {
  const GlobalProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: LoadingIndicator(
        indicatorType: Indicator.ballScaleMultiple,
        colors: [primaryAmber,secundaryAmber],
        strokeWidth: 1,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

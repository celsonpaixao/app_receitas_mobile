import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalShimmer extends StatelessWidget {
  final double border;
  final double shimmerWidth;
  final double shimmerHeight;

  const GlobalShimmer(
      {super.key,
      required this.shimmerWidth,
      required this.shimmerHeight,
      required this.border});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade200,
        child: Container(
          width: shimmerWidth,
          height: shimmerHeight,
          decoration: BoxDecoration(
            color: primaryWhite,
            borderRadius: BorderRadius.circular(border),
          ), // Cor de fundo simulada
        ));
  }
}

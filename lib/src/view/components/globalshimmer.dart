import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalShimmer extends StatelessWidget {
  final int acount;
  final double border;
  final double shimmer_width;
  final double shimmer_heigth;
  final double horizontal_padding;
  final double vertical_padding;
  final Axis direction;
  const GlobalShimmer({
    super.key,
    required this.acount,
    required this.shimmer_width,
    required this.shimmer_heigth,
    required this.horizontal_padding,
    required this.vertical_padding, required this.border, required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade200,
      child: ListView.builder(
        scrollDirection: direction,
        itemCount: acount, // Apenas para simular vários itens
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontal_padding, vertical: vertical_padding),
            child: Container(
              width: shimmer_width,
              height: shimmer_heigth,
              decoration: BoxDecoration(
                color: primaryWite,
                borderRadius: BorderRadius.circular(border)
              ), // Cor de fundo simulada
            ),
          );
        },
      ),
    );
  }
}

import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:flutter/material.dart';

import '../styles/colores.dart';

class MiniCardRecipeShimmer extends StatelessWidget {
  const MiniCardRecipeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: secundaryGrey, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlobalShimmer(
                  shimmerWidth: 200,
                  shimmerHeight: 150,
                  border: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GlobalShimmer(
                  shimmerWidth: 100,
                  shimmerHeight: 20,
                  border: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GlobalShimmer(
                  shimmerWidth: 150,
                  shimmerHeight: 10,
                  border: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GlobalShimmer(
                  shimmerWidth: 130,
                  shimmerHeight: 10,
                  border: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GlobalShimmer(
                  shimmerWidth: 150,
                  shimmerHeight: 10,
                  border: 6,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

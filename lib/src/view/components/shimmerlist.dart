import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:flutter/material.dart';

import '../styles/colores.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: secundaryGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlobalShimmer(
                    shimmerWidth: 100,
                    shimmerHeight: 100,
                    border: 6,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GlobalShimmer(
                        shimmerWidth: 150,
                        shimmerHeight: 30,
                        border: 8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GlobalShimmer(
                        shimmerWidth: 150,
                        shimmerHeight: 10,
                        border: 8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GlobalShimmer(
                        shimmerWidth: 150,
                        shimmerHeight: 10,
                        border: 8,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

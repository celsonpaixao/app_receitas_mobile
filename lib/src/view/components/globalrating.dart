import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GlobalRating extends StatelessWidget {
  final double value;
  final int count;
  final double sizeStar;
  const GlobalRating({
    super.key,
    required this.count,
    required this.value, required this.sizeStar,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: value,
      minRating: 0,
      direction: Axis.horizontal,
      itemCount: count,
      itemSize: sizeStar,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        // Handle rating update
      },
    );
  }
}

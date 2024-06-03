import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final double value;
  const Spacing({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * value,
    );
  }
}

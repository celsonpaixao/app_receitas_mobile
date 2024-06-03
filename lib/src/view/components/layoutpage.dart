import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  final Widget body;
  const LayoutPage({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: body,
    );
  }
}

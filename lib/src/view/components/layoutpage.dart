import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  final Widget body;
  const LayoutPage({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);

        if (!focusScopeNode.hasPrimaryFocus) {
          focusScopeNode.unfocus();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: body,
      ),
    );
  }
}

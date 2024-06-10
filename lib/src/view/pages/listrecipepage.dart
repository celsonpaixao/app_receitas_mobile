import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:flutter/material.dart';

class ListRecipePage extends StatefulWidget {
  const ListRecipePage({super.key});

  @override
  State<ListRecipePage> createState() => _ListRecipePageState();
}

class _ListRecipePageState extends State<ListRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutPage(
        body: Center(
          child: Text("Liste Recipe Page"),
        ),
      ),
    );
  }
}

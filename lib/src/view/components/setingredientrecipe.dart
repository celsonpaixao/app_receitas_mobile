import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class SetIngredientsRecipe extends StatefulWidget {
  final Function(String) onIngredientAdded;
  final String? Function(String? value) validator; // Correção aqui

  const SetIngredientsRecipe({
    Key? key,
    required this.onIngredientAdded,
    required this.validator, // Correção aqui
  }) : super(key: key);

  @override
  _SetIngredientsRecipeState createState() => _SetIngredientsRecipeState();
}

class _SetIngredientsRecipeState extends State<SetIngredientsRecipe> {
  final TextEditingController _ingredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GlobalInput(
                controller: _ingredientController,
                validator: widget.validator, // Correção aqui
                hintText: "Ingredientes",
                ispassword: false,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: primaryAmber,),
              onPressed: () {
                if (_ingredientController.text.isNotEmpty) {
                  widget.onIngredientAdded(_ingredientController.text);
                  _ingredientController.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';

class SetIngredientsRecipe extends StatefulWidget {
  final Function(String) onIngredientAdded;

  const SetIngredientsRecipe({
    Key? key,
    required this.onIngredientAdded,
  }) : super(key: key);

  @override
  _SetIngredientsRecipeState createState() => _SetIngredientsRecipeState();
}

class _SetIngredientsRecipeState extends State<SetIngredientsRecipe> {
  final TextEditingController _ingredientController = TextEditingController();
  List<String> _ingredientList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lista de ingredientes adicionados
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _ingredientList.asMap().entries.map((entry) {
            int index = entry.key;
            String ingredient = entry.value;
            return Row(
              children: [
                Expanded(
                  child: Text(
                    ingredient,
                    style: TextStyle(color: primaryAmber),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _ingredientList.removeAt(index);
                    });
                  },
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 8), // Espaço adicional opcional
        Divider(), // Linha divisória entre entrada de ingrediente e lista
        SizedBox(height: 8), // Espaço adicional opcional
        Row(
          children: [
            Expanded(
              child: GlobalInput(
                controller: _ingredientController,
                hintText: "Adicionar Ingrediente",
                ispassword: false,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: primaryAmber),
              onPressed: () {
                if (_ingredientController.text.isNotEmpty) {
                  widget.onIngredientAdded(_ingredientController.text);
                  setState(() {
                    _ingredientList.add(_ingredientController.text);
                    _ingredientController.clear();
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

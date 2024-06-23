import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';

class SetMaterialsRecipe extends StatefulWidget {
  final Function(String) onMaterialAdded;

  const SetMaterialsRecipe({
    Key? key,
    required this.onMaterialAdded,
  }) : super(key: key);

  @override
  _SetMaterialsRecipeState createState() => _SetMaterialsRecipeState();
}

class _SetMaterialsRecipeState extends State<SetMaterialsRecipe> {
  final TextEditingController _materialController = TextEditingController();
  List<String> _materialList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lista de materiais adicionados
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _materialList.asMap().entries.map((entry) {
            int index = entry.key;
            String material = entry.value;
            return Row(
              children: [
                Expanded(
                  child: Text(
                    material,
                    style: TextStyle(color: primaryAmber),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _materialList.removeAt(index);
                    });
                  },
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 8), // Espaço adicional opcional
        Divider(), // Linha divisória entre entrada de material e lista
        SizedBox(height: 8), // E
        Row(
          children: [
            Expanded(
              child: GlobalInput(
                controller: _materialController,
                hintText: "Adicionar Material",
                ispassword: false,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: primaryAmber),
              onPressed: () {
                if (_materialController.text.isNotEmpty) {
                  widget.onMaterialAdded(_materialController.text);
                  setState(() {
                    _materialList.add(_materialController.text);
                    _materialController.clear();
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

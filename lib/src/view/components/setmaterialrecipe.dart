import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class SetMaterialsRecipe extends StatefulWidget {
  final Function(String) onMaterialAdded;
  final String? Function(String? value) validator; // Correção aqui

  const SetMaterialsRecipe(
      {Key? key, required this.onMaterialAdded, required this.validator})
      : super(key: key);

  @override
  _SetMaterialsRecipeState createState() => _SetMaterialsRecipeState();
}

class _SetMaterialsRecipeState extends State<SetMaterialsRecipe> {
  final TextEditingController _materialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: GlobalInput(
              hintText: "Material",
              ispassword: false,
              validator: widget.validator,
            )),
            IconButton(
              icon: Icon(
                Icons.add,
                color: primaryAmber,
              ),
              onPressed: () {
                if (_materialController.text.isNotEmpty) {
                  widget.onMaterialAdded(_materialController.text);
                  _materialController.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

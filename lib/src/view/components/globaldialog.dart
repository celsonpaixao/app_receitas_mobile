import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';

class GlobalDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String text;

  const GlobalDialog({
    Key? key,
    required this.onConfirm,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Tem certeza que deseja fazer isso?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: Text(
            'Cancelar',
            style: TextStyle(color: primaryWhite),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: Text(
            'Confirmar',
            style: TextStyle(color: primaryWhite),
          ),
          onPressed: () {
            onConfirm(); // Chama o callback passado para confirmar a ação
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

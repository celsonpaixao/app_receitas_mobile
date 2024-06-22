import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/view/components/globalmulttextinpu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import '../styles/colores.dart';
import '../../controller/ratingController.dart';

class GlobalDialogEditRating extends StatefulWidget {
  final String message;
  double setRating;
  final int ratingId;
  final RatingController ratingController;

  GlobalDialogEditRating({
    Key? key,
    required this.message,
    required this.setRating,
    required this.ratingId,
    required this.ratingController,
  }) : super(key: key);

  @override
  _GlobalDialogEditRatingState createState() => _GlobalDialogEditRatingState();
}

class _GlobalDialogEditRatingState extends State<GlobalDialogEditRating> {
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController(text: widget.message);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar Avaliação"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PannableRatingBar.builder(
              rate: widget.setRating,
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 0,
              itemCount: 5,
              direction: Axis.horizontal,
              itemBuilder: (context, index) {
                return RatingWidget(
                  selectedColor: Colors.amber,
                  unSelectedColor: secundaryGrey,
                  child: Icon(
                    Icons.star,
                    size: 35,
                  ),
                );
              },
              onChanged: (value) {
                setState(() {
                  widget.setRating = value;
                });
              },
            ),
            const SizedBox(height: 16),
            GlobalMultTextInput(
              controller: _messageController,
              hintText: 'Digite sua avaliação...',
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            if (widget.ratingController != null &&
                _messageController.text.isNotEmpty) {
              // Cria uma nova instância de RatingModel com os dados atualizados
              RatingModel updatedRating = RatingModel(
                id: widget.ratingId,
                value: widget.setRating,
                message: _messageController.text,
              );

              // Chama o método updateRating do RatingController
              await widget.ratingController.updateRating(
                widget.ratingId,
                updatedRating,
              );

              // Fecha o diálogo após a atualização bem-sucedida
              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Confirmar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

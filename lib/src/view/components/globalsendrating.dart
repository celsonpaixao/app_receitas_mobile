import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../controller/ratingController.dart';
import '../../model/ratingModel.dart';
import '../styles/colores.dart';
import 'globalmulttextinpu.dart';
import 'globalprogress.dart';

class GlobalSendRating extends StatefulWidget {
  final TextEditingController messagecontroller;
  final int userId;
  final int recipeId;

  const GlobalSendRating({
    Key? key,
    required this.messagecontroller,
    required this.userId,
    required this.recipeId,
  }) : super(key: key);

  @override
  _GlobalSendRatingState createState() => _GlobalSendRatingState();
}

class _GlobalSendRatingState extends State<GlobalSendRating> {
  double _setRating = 0.0;
  bool _isLoading = false;

  Future<void> _publishRating() async {
    setState(() {
      _isLoading = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: GlobalProgress(),
        );
      },
    );

    try {
      final ratingController =
          Provider.of<RatingController>(context, listen: false);
      await ratingController.publishRating(
        widget.userId,
        widget.recipeId,
        RatingModel(
          value: _setRating,
          message: widget.messagecontroller.text,
        ),
      );

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Avaliação enviada com sucesso!'),
        backgroundColor: Colors.green,
      ));

      widget.messagecontroller.clear();

      setState(() {
        _setRating = 0.0;
      });
    } catch (e) {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Falha ao enviar a avaliação. Por favor, tente novamente.'),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PannableRatingBar.builder(
          rate: _setRating,
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
              _setRating = value;
            });
          },
        ),
        const SizedBox(height: 16),
        GlobalMultTextInput(
          hintText: "O que achou desta receita?",
          controller: widget.messagecontroller,
          sufixIcon: IconButton(
            onPressed: _isLoading ? null : _publishRating,
            icon: const Icon(Icons.send),
          ),
        ),
      ],
    );
  }
}

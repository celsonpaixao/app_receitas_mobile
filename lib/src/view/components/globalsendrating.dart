import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/repository/ratingRepository.dart';
import 'package:app_receitas_mobile/src/view/components/globalmulttextinpu.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  Future<void> _pulichRating() async {
  //  showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return Center(
  //           child: GlobalProgress(),
  //         );
  //       },
  //     );
    await RatingRepository().publicaRating(
      widget.userId,
      widget.recipeId,
      RatingModel(
        value: _setRating,
        message: widget.messagecontroller.text,
      ),
    );

    // Navigator.of(context).pop();
    // Limpar o campo de mensagem após envio
    widget.messagecontroller.clear();
    setState(() {
      _setRating = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar.builder(
          itemCount: 5,
          itemSize: 30,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _setRating = rating;
            });
          },
        ),
        const Spacing(value: 0.01),
        GlobalMultTextInput(
          hintText: "O que achou desta receita?",
          controller: widget.messagecontroller,
          sufixIcon: IconButton(
            onPressed: _pulichRating,
            icon: const Icon(Icons.send),
          ),
        ),
      ],
    );
  }
}

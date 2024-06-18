import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app_receitas_mobile/src/controller/ratingController.dart';
import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/view/components/globalmulttextinpu.dart';
import 'package:app_receitas_mobile/src/view/components/globalprogress.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';

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
  RatingController controller = RatingController();

  Future<void> publishRating() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: GlobalProgress(),
        );
      },
    );

    await controller.publishRating(
      widget.userId,
      widget.recipeId,
      RatingModel(
        value: _setRating,
        message: widget.messagecontroller.text,
      ),
    );

    Navigator.of(context).pop();

    // Clear the message field after sending
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
            onPressed: publishRating,
            icon: const Icon(Icons.send),
          ),
        ),
      ],
    );
  }
}

import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/ratingModel.dart';
import 'package:app_receitas_mobile/src/view/components/globalmulttextinpu.dart';
import 'package:app_receitas_mobile/src/view/components/globalprogress.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../repository/ratingRepository.dart';
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
  late DTOresponse rating;
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
      rating = await RatingRepository().publicaRating(
        widget.userId,
        widget.recipeId,
        RatingModel(
          value: _setRating,
          message: widget.messagecontroller.text,
        ),
      );
      Navigator.of(context).pop();
      // Show success message or handle response accordingly
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Rating submitted successfully!'),
      ));
    } catch (e) {
      Navigator.of(context).pop();
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit rating. Please try again.'),
      ));
    } finally {
      setState(() {
        _isLoading = false;
        _setRating = 0.0;
      });
      widget.messagecontroller.clear();
      _setRating = 0.0;
    }
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
            onPressed: _isLoading ? null : _publishRating,
            icon: const Icon(Icons.send),
          ),
        ),
      ],
    );
  }
}

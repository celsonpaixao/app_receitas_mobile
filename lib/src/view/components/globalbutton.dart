import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final String textButton;
  final void Function() onClick;
  final Color background;
  final Color textColor;
  const GlobalButton({
    super.key,
    required this.textButton,
    required this.onClick,
    required this.background,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      height:  55,
      child: TextButton(
        onPressed: onClick,
        child: Text(
          textButton,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(background),
          elevation: MaterialStatePropertyAll(334),
          overlayColor: MaterialStatePropertyAll(textColor.withOpacity(.20)),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

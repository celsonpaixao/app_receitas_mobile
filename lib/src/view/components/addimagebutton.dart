import 'package:flutter/material.dart';

import '../styles/colores.dart';

class AddImageButton extends StatelessWidget {
  final void Function()? onclicked;
  const AddImageButton({
    super.key,
    this.onclicked,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        maximumSize: MaterialStatePropertyAll(Size(40, 40)),
        backgroundColor: MaterialStatePropertyAll(
          primaryWhite.withOpacity(.5),
        ),
      ),
      onPressed: onclicked,
      icon: Center(
        child: Icon(
          Icons.camera_alt_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}

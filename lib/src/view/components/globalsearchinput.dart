import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class GlobalSearchInput extends StatelessWidget {
  final Widget? sufixIcon;
  final TextEditingController? controller;
  final void Function(String)? onchange;
  const GlobalSearchInput(
      {super.key, this.sufixIcon, this.onchange, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 35,
      child: TextField(
        keyboardType: TextInputType.text,
        cursorColor: primaryWhite,
        scrollPadding: EdgeInsets.all(0),
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: primaryWhite.withOpacity(.2),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryWhite),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryWhite),
          ),
          contentPadding: EdgeInsets.all(0),
          hintText: "Procurar Receita...!",
          hintStyle: TextStyle(
            color: primaryWhite,
            fontWeight: FontWeight.normal,
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: primaryWhite,
            size: 20,
          ),
          suffix: sufixIcon,
        ),
        onChanged: onchange,
      ),
    );
  }
}

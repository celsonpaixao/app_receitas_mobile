import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class GlobalSearchInput extends StatelessWidget {
  final Widget? sufixIcon;
  final void Function(String)? onchange;
  const GlobalSearchInput({super.key, this.sufixIcon, this.onchange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      cursorColor: primaryWite,
      decoration: InputDecoration(
          filled: true,
          fillColor: primaryWite.withOpacity(.2),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryWite),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryWite),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          hintText: "Procurar Receita...!",
          hintStyle: TextStyle(
              color: primaryWite, fontWeight: FontWeight.normal, fontSize: 14),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: primaryWite,
          ),
          suffix: sufixIcon),
      onChanged: onchange,
    );
  }
}

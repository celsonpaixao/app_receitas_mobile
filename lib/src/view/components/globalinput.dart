import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

class GlobalInput extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final TextEditingController? controller;
  final bool ispassword;
  final TextInputType? type;
  final void Function(String)? onchange;
  final String? Function(String? value)? validator;

  const GlobalInput({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    this.controller,
    required this.ispassword,
    this.onchange,
    this.type,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onchange,
      validator: validator,
      keyboardType: type,
      maxLines: 1,
      obscureText: ispassword,
      cursorColor: primaryAmber,
      style: TextStyle(
        color: primaryAmber,
      ),
      decoration: InputDecoration(
        
          contentPadding: EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: primaryAmber,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: primaryAmber,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: primaryAmber,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          prefixIconColor: primaryAmber,
          suffixIconColor: primaryAmber),
    );
  }
}

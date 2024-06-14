import 'package:flutter/material.dart';
import '../styles/colores.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final Widget? title;
  final bool? titlecenter;

  const GlobalAppBar({super.key, this.height, this.title, this.titlecenter});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryAmber,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      flexibleSpace: Container(
        alignment: Alignment.topRight,
        child: Image.asset("assets/images/appbarover.png"),
      ),
      surfaceTintColor: primaryAmber,
      title: title,
      centerTitle: titlecenter,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}

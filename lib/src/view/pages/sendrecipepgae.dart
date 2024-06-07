import 'package:app_receitas_mobile/src/view/components/globalbaclbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/components/globalmulttextinpu.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/selectcategorys.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/addimagebutton.dart';

class SendRecipePage extends StatefulWidget {
  const SendRecipePage({Key? key});

  @override
  State<SendRecipePage> createState() => _SendRecipePageState();
}

class _SendRecipePageState extends State<SendRecipePage> {
  @override
  Widget build(BuildContext context) {
    final List<int> _Id_CategorysController = [];
    final String defultimage =
        "assets/images/b844ef8b6b63db7380bdcb229955b8ae-12-754x394.jpg";
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        automaticallyImplyLeading: false, // Remove the back button
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(defultimage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Globalbackbutton(), AddImageButton()],
          ),
        ), // Adicione um título, se necessário
        centerTitle: true, // Centralize o título
      ),
      body: LayoutPage(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Publicar nova receita",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GlobalInput(hintText: "Título", ispassword: false),
              Spacing(value: .02),
              GlobalMultTextInput(hintText: "Descrição"),
              Spacing(value: .03),
              Text(
                "Categoria",
                style: TextStyle(
                  color: primaryAmber
                ),
              ),
               Spacing(value: .009),
              SelectCategory(
                CategorysIds: _Id_CategorysController,
              ),
               Spacing(value: .02),
              GlobalButton(
                textButton: "Publicar",
                onClick: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Receita com ${_Id_CategorysController.length} Categorias"),
                    ),
                  );
                },
                background: primaryAmber,
                textColor: primaryWite,
              )
            ],
          ),
        ),
      ),
    );
  }
}

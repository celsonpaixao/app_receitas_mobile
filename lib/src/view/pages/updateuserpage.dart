import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/view/components/globalappbar.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';

class UpdateUserPage extends StatefulWidget {
  final UserModel userdate;
  const UpdateUserPage({super.key, required this.userdate});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final TextEditingController newfirtNameController = TextEditingController();
  final TextEditingController newlastNameController = TextEditingController();
  final TextEditingController newemailController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  @override
  @override
  void initState() {
    super.initState();
    newfirtNameController.text = widget.userdate.firstName;
    newlastNameController.text = widget.userdate.lastName;
    newemailController.text = widget.userdate.email;
    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: Text(
          "Atualizar dados do Usuário",
          style: white_text_title,
        ),
        titlecenter: true,
      ),
      body: LayoutPage(
          body: Column(
        children: [
          Spacing(value: .01),
          GlobalInput(
            hintText: "Atualizar Primeiro Nome",
            ispassword: false,
            prefixIcon: Icon(Icons.person),
            controller: newfirtNameController,
          ),
          Spacing(value: .01),
          GlobalInput(
            hintText: "Atualizar Ultimo Nome",
            ispassword: false,
            prefixIcon: Icon(Icons.person),
            controller: newlastNameController,
          ),
          Spacing(value: .01),
          GlobalInput(
            hintText: "Atualizar Email",
            ispassword: false,
            prefixIcon: Icon(Icons.email),
            controller: newemailController,
          ),
          Spacing(value: .01),
          GlobalInput(
            hintText: "Atualizar Password",
            ispassword: false,
            prefixIcon: Icon(Icons.lock),
            controller: newpasswordController,
          ),
          Spacing(value: .01),

          GlobalInput(
            hintText: "Confirmar password",
            ispassword: false,
            prefixIcon: Icon(Icons.lock),
            controller: confirmpasswordController,
          ),
          Spacing(value: .01),
          GlobalButton(
            textButton: "Atualizar",
            onClick: () {},
            background: primaryAmber,
            textColor: primaryWhite,
          )
        ],
      )),
    );
  }
}

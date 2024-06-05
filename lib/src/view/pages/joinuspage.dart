import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/validator/inputvalidators.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:flutter/material.dart';

import '../../controller/userController.dart';
import '../components/globalbutton.dart';
import '../components/globalprogress.dart';
import '../styles/colores.dart';
import '../styles/texts.dart';

class JoinUsPage extends StatefulWidget {
  const JoinUsPage({super.key});

  @override
  State<JoinUsPage> createState() => _JoinUsPageState();
}

class _JoinUsPageState extends State<JoinUsPage> {
  bool secretText = true;
  bool confirmSecretText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final UserController userController = UserController();

  Future<void> _registernewuser() async {
    UserModel user = UserModel(
      first_name: _firstNameController.text,
      last_name: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (_formKey.currentState!.validate()) {
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
        var response = await userController.JoinUsUser(
            user, _confirmPasswordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text(response)),
        );
        // Navegar para a página de login após o registro bem-sucedido
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        String msg = e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(msg)),
        );
      } finally {
        // Fechar o indicador de progresso
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutPage(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacing(value: .03),
                  Image.asset(
                    "assets/images/Add User-bro.png",
                    width: 300,
                    height: 300,
                  ),
                  GlobalInput(
                    controller: _firstNameController,
                    hintText: "Primeiro Nome",
                    ispassword: false,
                    type: TextInputType.name,
                    prefixIcon: Icon(Icons.person_outline),
                    validator: InputValidator.validateName,
                  ),
                  Spacing(value: .02),
                  GlobalInput(
                    controller: _lastNameController,
                    hintText: "Último Nome",
                    ispassword: false,
                    type: TextInputType.name,
                    prefixIcon: Icon(Icons.person_outline),
                    validator: InputValidator.validateName,
                  ),
                  Spacing(value: .02),
                  GlobalInput(
                    controller: _emailController,
                    hintText: "Email",
                    ispassword: false,
                    type: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined),
                    validator: InputValidator.validateEmail,
                  ),
                  Spacing(value: .02),
                  GlobalInput(
                    controller: _passwordController,
                    hintText: "Password",
                    ispassword: secretText,
                    type: TextInputType.visiblePassword,
                    prefixIcon: Icon(Icons.lock_outline),
                    sufixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          secretText = !secretText;
                        });
                      },
                      icon: Icon(
                        secretText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    validator: InputValidator.validatePassword,
                  ),
                  Spacing(value: .02),
                  GlobalInput(
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    type: TextInputType.visiblePassword,
                    ispassword: confirmSecretText,
                    prefixIcon: Icon(Icons.lock_outline),
                    sufixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          confirmSecretText = !confirmSecretText;
                        });
                      },
                      icon: Icon(
                        confirmSecretText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    validator: (value) =>
                        InputValidator.validateConfirmPassword(
                            _passwordController.text, value),
                  ),
                  Spacing(value: .02),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: Text(
                      "Já possui uma conta? Clique aqui",
                      style: Amber_Text_Normal,
                    ),
                  ),
                  Spacing(value: .02),
                  GlobalButton(
                    textButton: "Cadastrar",
                    onClick: _registernewuser,
                    background: primaryAmber,
                    textColor: primaryWite,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

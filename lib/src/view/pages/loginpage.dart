import 'package:app_receitas_mobile/src/utils/validator/inputvalidators.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/joinuspage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';
// Import validators

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool secretText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWite,
      body: SafeArea(
        child: LayoutPage(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacing(value: .04),
                  Image.asset(
                    "assets/images/Login-cuate.png",
                    width: 300,
                    height: 300,
                  ),
                  GlobalInput(
                    controller: _emailController,
                    type: TextInputType.emailAddress,
                    hintText: "E-mail",
                    ispassword: false,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                    validator:
                        InputValidator.validateEmail, // Use the validator
                  ),
                  Spacing(value: .03),
                  GlobalInput(
                    controller: _passwordController,
                    hintText: "Password",
                    type: TextInputType.visiblePassword,
                    ispassword: secretText,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
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
                    validator:
                        InputValidator.validatePassword, // Use the validator
                  ),
                  Spacing(value: .02),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JoinUsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Ainda não possui uma conta? Clique aqui",
                      style: Amber_Text_Normal,
                    ),
                  ),
                  Spacing(value: .02),
                  GlobalButton(
                    textButton: "Entrar",
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        // Processo de login
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                             backgroundColor: Colors.green,
                              content: Text('Login efetuado com sucesso!')),
                        );
                      }
                    },
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

import 'package:app_receitas_mobile/src/controller/userController.dart';
import 'package:app_receitas_mobile/src/utils/validator/inputvalidators.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/homepage.dart';
import 'package:app_receitas_mobile/src/view/pages/joinuspage.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final UserController userController = UserController();

  Future<void> _authenticateAndStoreToken() async {
    if (_formKey.currentState!.validate()) {
      try {
        final token = await userController.LoginUser(
          _emailController.text,
          _passwordController.text,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        print('Token armazenado com sucesso: $token');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text('Sucesso!!')),
        );
        // Navegar para a página inicial após o login bem-sucedido
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        String msg = "";
        if (e.toString() == "Exception: Exception: This user does not exist") {
          msg = "Não Existe nenhum usuário com este email !!";
        }
        if (e.toString() == "Exception: Exception: Incorrect password") {
          msg = "A password está incorreta!!";
        } else {
          msg = e.toString();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(msg)),
        );
      }
    }
  }


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
                    validator: InputValidator.validateEmail,
                  ),
                  Spacing(
                    value: .03,
                  ),
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
                    validator: InputValidator.validatePassword,
                  ),
                  Spacing(
                    value: .02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JoinUsPage(),
                          ));
                    },
                    child: Text(
                      "Ainda não possui uma conta? Clique aqui",
                      style: Amber_Text_Normal,
                    ),
                  ),
                  Spacing(
                    value: .02,
                  ),
                  GlobalButton(
                    textButton: "Entrar",
                    onClick: _authenticateAndStoreToken,
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

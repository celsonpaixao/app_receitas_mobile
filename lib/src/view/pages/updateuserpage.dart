import 'dart:io';
import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/controller/userController.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/view/components/globalprogress.dart';
import 'package:app_receitas_mobile/src/view/pages/welcomepage.dart';
import 'package:app_receitas_mobile/src/view/routerpages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/globalappbar.dart';
import '../components/globalbutton.dart';
import '../components/globalinput.dart';
import '../components/layoutpage.dart';
import '../components/spacing.dart';
import '../styles/colores.dart';
import '../styles/texts.dart';

class UpdateUserPage extends StatefulWidget {
  final UserController userController;
  final UserModel userdate;

  const UpdateUserPage({
    Key? key,
    required this.userdate,
    required this.userController,
  }) : super(key: key);

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController newFirstNameController = TextEditingController();
  final TextEditingController newLastNameController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  File? _image; // Armazenar a imagem selecionada

  @override
  void initState() {
    super.initState();
    newFirstNameController.text = widget.userdate.firstName;
    newLastNameController.text = widget.userdate.lastName;
    newEmailController.text = widget.userdate.email;
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _deleteUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: GlobalProgress(),
        );
      },
    );
    DTOresponse response =
        await widget.userController.deletUser(widget.userdate.id!);

    Navigator.of(context).pop();

    if (response.success) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("auth_token");
      await sharedPreferences.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green, content: Text(response.message)),
      );

      // Navegar para a página inicial após o login bem-sucedido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(response.message)),
      );
    }
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('As senhas não coincidem')),
        );
        return;
      }

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: GlobalProgress(),
            );
          },
        );
        DTOresponse response = await widget.userController.updateUser(
          widget.userdate.id!,
          newFirstNameController.text,
          newLastNameController.text,
          newEmailController.text,
          newPasswordController.text,
          confirmPasswordController.text,
          _image!,
        );

        Navigator.of(context).pop();

        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(response.message),
            ),
          );
          setState(() {});
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RouterPage()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Erro ao atualizar usuário: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              minWidth: 40,
              height: 40,
              child: Icon(
                Icons.arrow_back_ios,
                color: primaryWhite,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RouterPage(),
                    ));
              },
            ),
            Text(
              "Configurações",
              style: white_text_title,
            ),
            MaterialButton(
              minWidth: 40,
              height: 40,
              onPressed: () {},
            ),
          ],
        ),
        titlecenter: true,
      ),
      body: LayoutPage(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => _showImagePickerOptions(),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 100,
                      width: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.file(
                                _image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : (widget.userdate.imageURL != null &&
                                  widget.userdate.imageURL!.isNotEmpty)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(
                                    "$baseUrl/${widget.userdate.imageURL!}",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    "assets/images/Depositphotos_484354208_S.jpg",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                    ),
                  ),
                ),
                Spacing(value: .01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: primaryAmber,
                      foregroundColor: primaryWhite,
                      onPressed: () => _getImage(ImageSource.camera),
                      tooltip: 'Câmera',
                      heroTag: 'camera',
                      child: Icon(Icons.photo_camera),
                    ),
                    SizedBox(width: 16.0),
                    FloatingActionButton(
                      backgroundColor: primaryAmber,
                      foregroundColor: primaryWhite,
                      onPressed: () => _getImage(ImageSource.gallery),
                      tooltip: 'Galeria',
                      heroTag: 'gallery',
                      child: Icon(Icons.photo_library),
                    ),
                  ],
                ),
                Spacing(value: .03),
                GlobalInput(
                  hintText: "Atualizar Primeiro Nome",
                  ispassword: false,
                  prefixIcon: Icon(Icons.person),
                  controller: newFirstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o primeiro nome';
                    }
                    return null;
                  },
                ),
                Spacing(value: .01),
                GlobalInput(
                  hintText: "Atualizar Último Nome",
                  ispassword: false,
                  prefixIcon: Icon(Icons.person),
                  controller: newLastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o último nome';
                    }
                    return null;
                  },
                ),
                Spacing(value: .01),
                GlobalInput(
                  hintText: "Atualizar Email",
                  ispassword: false,
                  prefixIcon: Icon(Icons.email),
                  controller: newEmailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                Spacing(value: .01),
                GlobalInput(
                  hintText: "Atualizar Senha",
                  ispassword: true,
                  prefixIcon: Icon(Icons.lock),
                  controller: newPasswordController,
                  validator: (value) {
                    if (value != null && value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                Spacing(value: .01),
                GlobalInput(
                  hintText: "Confirmar Senha",
                  ispassword: true,
                  prefixIcon: Icon(Icons.lock),
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value != null && value != newPasswordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                Spacing(value: .02),
                GlobalButton(
                  textButton: "Atualizar",
                  onClick: () {
                    if (_image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Por favor, selecione uma imagem')),
                      );
                    } else {
                      _updateUser();
                    }
                  },
                  background: primaryAmber,
                  textColor: primaryWhite,
                ),
                Spacing(value: .01),
                GlobalButton(
                  textButton: "Apagar Conta",
                  onClick: _deleteUser,
                  background: Colors.red,
                  textColor: primaryWhite,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Câmera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galeria'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

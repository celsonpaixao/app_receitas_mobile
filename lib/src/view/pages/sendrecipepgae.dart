import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/repository/recipeRepository.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/components/globalmulttextinpu.dart';
import 'package:app_receitas_mobile/src/view/components/selectcategorys.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import '../components/globalbaclbutton.dart';
import '../components/setingredientrecipe.dart';
import '../components/setmaterialrecipe.dart';

class SendRecipePage extends StatefulWidget {
  final UserModel user;
  const SendRecipePage({Key? key, required this.user}) : super(key: key);

  @override
  State<SendRecipePage> createState() => _SendRecipePageState();
}

class _SendRecipePageState extends State<SendRecipePage> {
  late RecipeController _recipeController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _materials = [];
  final List<int> _Id_CategorysController = [];
  final List<String> _ingredients = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _recipeController = RecipeController(recipeRepository: RecipeRepository());
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 600,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _publishRecipe() async {
    if (_formKey.currentState!.validate() && _image != null) {
      try {
        setState(() {
          _isLoading = true;
        });

        Uint8List bytes = await _image!.readAsBytes();

        await _recipeController.publishRecipe(
          title: _titleController.text,
          description: _descriptionController.text,
          instructions: _instructionsController.text,
          userId: widget.user.id!,
          categories: _Id_CategorysController,
          ingredients: _ingredients,
          materials: _materials,
          bytes: bytes,
        );

        // Limpar formulário após publicação com sucesso
        _formKey.currentState!.reset();
        setState(() {
          _materials.clear();
          _Id_CategorysController.clear();
          _ingredients.clear();
          _image = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Receita publicada com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao publicar receita: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione uma imagem.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String defaultImage =
        "assets/images/b844ef8b6b63db7380bdcb229955b8ae-12-754x394.jpg";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            backgroundColor: primaryAmber,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Globalbackbutton(),
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _image != null
                  ? Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      defaultImage,
                      fit: BoxFit.cover,
                    ),
              title: Text(
                "Publicar nova receita",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryWhite,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.photo_camera,
                  color: primaryWhite,
                ),
                onPressed: () {
                  _getImage(ImageSource.camera);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.photo_library,
                  color: primaryWhite,
                ),
                onPressed: () {
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalInput(
                      controller: _titleController,
                      hintText: "Título",
                      ispassword: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o título da receita';
                        }
                        return null;
                      },
                    ),
                    Spacing(value: 0.02),
                    GlobalMultTextInput(
                      controller: _descriptionController,
                      hintText: "Descrição",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a descrição da receita';
                        }
                        return null;
                      },
                    ),
                    Spacing(value: 0.03),
                    Text(
                      "Categoria",
                      style: TextStyle(color: primaryAmber),
                    ),
                    Spacing(value: 0.009),
                    SelectCategory(
                      CategorysIds: _Id_CategorysController,
                    ),
                    Spacing(value: 0.03),
                    SetMaterialsRecipe(
                      onMaterialAdded: (material) {
                        setState(() {
                          _materials.add(material);
                        });
                      },
                    ),
                    Spacing(value: 0.02),
                    SetIngredientsRecipe(
                      onIngredientAdded: (ingredient) {
                        setState(() {
                          _ingredients.add(ingredient);
                        });
                      },
                    ),
                    Spacing(value: 0.02),
                    GlobalMultTextInput(
                      controller: _instructionsController,
                      hintText: "Instruções",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira as instruções da receita';
                        }
                        return null;
                      },
                    ),
                    Spacing(value: 0.02),
                    GlobalButton(
                      textButton: "Publicar",
                      onClick: _publishRecipe,
                      background: primaryAmber,
                      textColor: primaryWhite,
                    ),
                    if (_isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

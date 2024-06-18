import 'package:app_receitas_mobile/src/view/components/globalbaclbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalinput.dart';
import 'package:app_receitas_mobile/src/view/components/globalmulttextinpu.dart';
import 'package:app_receitas_mobile/src/view/components/selectcategorys.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

import '../components/setingredientrecipe.dart';
import '../components/setmaterialrecipe.dart';

class SendRecipePage extends StatefulWidget {
  const SendRecipePage({Key? key});

  @override
  State<SendRecipePage> createState() => _SendRecipePageState();
}

class _SendRecipePageState extends State<SendRecipePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _materials = [];
  final List<String> _ingredients = [];
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();

  void _addMaterial() {
    if (_materialController.text.isNotEmpty) {
      setState(() {
        _materials.add(_materialController.text);
        _materialController.clear();
      });
    }
  }

  void _addIngredient() {
    if (_ingredientController.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text);
        _ingredientController.clear();
      });
    }
  }

  void _removeMaterial(int index) {
    setState(() {
      _materials.removeAt(index);
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<int> _Id_CategorysController = [];
    final String defaultImage =
        "assets/images/b844ef8b6b63db7380bdcb229955b8ae-12-754x394.jpg";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            backgroundColor: primaryAmber,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Globalbackbutton(),
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                defaultImage,
                fit: BoxFit.cover,
              ),
              title: Text(
                "Publicar nova receita",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryWhite),
              ),
            ),
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
                      hintText: "Título",
                      ispassword: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um título';
                        }
                        return null;
                      },
                    ),
                    Spacing(value: .02),
                    GlobalMultTextInput(
                      hintText: "Descrição",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma descrição';
                        }
                        return null;
                      },
                    ),
                    Spacing(value: .03),
                    Text(
                      "Categoria",
                      style: TextStyle(color: primaryAmber),
                    ),
                    Spacing(value: .009),
                    SelectCategory(
                      CategorysIds: _Id_CategorysController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione uma categoria';
                        }
                        return null;
                      },
                    ),
                    Spacing(value: .03),
                    Text(
                      "Materiais",
                      style: TextStyle(color: primaryAmber),
                    ),
                    SetMaterialsRecipe(
                      onMaterialAdded: (material) {
                        setState(() {
                          _materials.add(material);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, adicione materiais';
                        }
                        return null;
                      },
                    ),
                    Spacing(value: .02),
                    Text(
                      "Ingredientes",
                      style: TextStyle(color: primaryAmber),
                    ),
                    SetIngredientsRecipe(
                      onIngredientAdded: (ingredient) {
                        setState(() {
                          _ingredients.add(ingredient);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, adicione ingredientes';
                        }
                        return null;
                      },
                    ),
                    Spacing(value: .02),
                    GlobalMultTextInput(hintText: "Instruções"),
                    Spacing(value: .02),
                    GlobalButton(
                      textButton: "Publicar",
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Receita publicada com ${_Id_CategorysController.length} Categorias, ${_materials.length} Materiais, e ${_ingredients.length} Ingredientes"),
                            ),
                          );
                        }
                      },
                      background: primaryAmber,
                      textColor: primaryWhite,
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

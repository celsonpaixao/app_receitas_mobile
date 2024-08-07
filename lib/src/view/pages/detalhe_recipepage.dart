import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/view/components/getingredientsrecipedeteihs.dart';
import 'package:app_receitas_mobile/src/view/components/getmaterialsrecipedeteilhs.dart';
import 'package:app_receitas_mobile/src/view/components/getratingsforrecipes.dart';
import 'package:app_receitas_mobile/src/view/components/globalbaclbutton.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';
import 'package:flutter/material.dart';

import '../components/getcategoryrecipedetelhs.dart';

class DetalheRecipePage extends StatefulWidget {
  final RecipeModel recipe;
  const DetalheRecipePage({Key? key, required this.recipe});

  @override
  State<DetalheRecipePage> createState() => _DetalheRecipePageState();
}

class _DetalheRecipePageState extends State<DetalheRecipePage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 250,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: primaryAmber,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, left: 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Globalbackbutton(),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: LayoutPage(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.recipe.title ?? 'Título não disponível',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacing(value: 0.02),
                      Text(
                        widget.recipe.description ?? 'Descrição não disponível',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Spacing(value: 0.02),
                      Text(
                        "Categorias da Receita",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacing(value: 0.02),
                      GetCategoryRecipeDetalhes(widget: widget),
                      Spacing(value: 0.02),
                      Text(
                        "Ingrediente da Receita",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacing(value: 0.02),
                      GetIngredientsRecipeDetalhs(widget: widget),
                      Spacing(value: 0.02),
                      Text(
                        "Materiais/Instrumentos usados",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacing(value: 0.02),
                      GetMaterialsRecipeDeteilhs(widget: widget),
                      Spacing(value: 0.02),
                      ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        children: [
                          ExpansionPanel(
                            backgroundColor: primaryAmber,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text(
                                  "Instruções",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: primaryWhite,
                                  ),
                                ),
                              );
                            },
                            body: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                widget.recipe.instructions ??
                                    'Instruções não disponíveis',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryWhite,
                                ),
                              ),
                            ),
                            isExpanded: _isExpanded,
                          ),
                        ],
                      ),
                      Spacing(value: 0.02),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Receita de: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.recipe.admin ??
                                  'Administrador não disponível',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: primaryGrey,
                      ),
                      GetRatingsForRecipe(widget: widget),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

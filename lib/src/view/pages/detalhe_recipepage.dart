import 'package:app_receitas_mobile/src/controller/recipeController.dart';
import 'package:app_receitas_mobile/src/model/recipeModel.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:app_receitas_mobile/src/view/components/getingredientsrecipedeteihs.dart';
import 'package:app_receitas_mobile/src/view/components/getmaterialsrecipedeteilhs.dart';
import 'package:app_receitas_mobile/src/view/components/getratingsforrecipes.dart';
import 'package:app_receitas_mobile/src/view/components/globalbaclbutton.dart';
import 'package:app_receitas_mobile/src/view/components/globalsendrating.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/auth/tokendecod.dart';
import '../components/getcategoryrecipedetelhs.dart';
import '../components/globlafavoritebutton.dart';
import '../styles/colores.dart';

class DetalheRecipePage extends StatefulWidget {
  final RecipeModel recipe;
  const DetalheRecipePage({Key? key, required this.recipe});

  @override
  State<DetalheRecipePage> createState() => _DetalheRecipePageState();
}

class _DetalheRecipePageState extends State<DetalheRecipePage> {
  bool _isExpanded = false;
  final TextEditingController messagecontroller = TextEditingController();
  UserModel? user;
  late final TokenDecod tokenDecod;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    tokenDecod = Provider.of<TokenDecod>(context, listen: false);
    try {
      final decodedUser = await tokenDecod.decodeUser();
      setState(() {
        user = decodedUser;
      });
    } catch (e) {
      print('Error loading user: $e');
    }
  }

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
                      decoration: BoxDecoration(
                        color: primaryAmber,
                        image: DecorationImage(
                          image: NetworkImage(
                            "$baseUrl/${widget.recipe.imageURL}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, left: 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Globalbackbutton(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GlobalFavoriteButton(
                                      item: widget.recipe,
                                      userId: user?.id ?? 0,
                                      recipeId: widget.recipe.id!,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Consumer<RecipeController>(
              builder: (context, recipeController, child) {
                return LayoutPage(
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.recipe.title ?? 'Título não disponível',
                            style: black_text_title,
                          ),
                          const Spacing(value: 0.02),
                          Text(
                            widget.recipe.description ??
                                'Descrição não disponível',
                            style: grey_text_normal,
                          ),
                          const Spacing(value: 0.02),
                          const Text(
                            "Categorias da Receita",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacing(value: 0.02),
                          GetCategoryRecipeDetalhes(widget: widget),
                          const Spacing(value: 0.02),
                          const Text(
                            "Ingrediente da Receita",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacing(value: 0.02),
                          GetIngredientsRecipeDetalhs(widget: widget),
                          const Spacing(value: 0.02),
                          const Text(
                            "Materiais/Instrumentos usados",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacing(value: 0.02),
                          GetMaterialsRecipeDeteilhs(widget: widget),
                          const Spacing(value: 0.02),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
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
                          const Spacing(value: 0.02),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
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
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: primaryGrey,
                          ),
                          const Spacing(value: 0.02),
                          GlobalSendRating(
                            userId: user?.id ?? 0,
                            recipeId: widget.recipe.id ?? 0,
                            messagecontroller: messagecontroller,
                          ),
                          const Spacing(value: 0.03),
                          const Text(
                            "Avaliações:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 200,
                              child: GetRatingsForRecipe(
                            recipeId: widget.recipe.id!,
                          )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

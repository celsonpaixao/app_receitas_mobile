
import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:flutter/material.dart';

import '../../controller/categoryController.dart';
import '../../model/categoryModel.dart';
import '../styles/colores.dart';

class SelectCategory extends StatefulWidget {
  final List<int> CategorysIds;
  const SelectCategory({Key? key, required this.CategorysIds});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List<CategoryModel> categories = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  Future<void> _loadCategory() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<CategoryModel> getCategories =
          await CategoryController().getCategoryList();
      setState(() {
        categories = getCategories;
        isLoading = false;
      });
    } catch (e) {
      // Tratar exceções aqui
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: primaryAmber),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isLoading
          ? ShimmerCategory()
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                var item = categories[index];
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: Text(
                        item.name!,
                        style: TextStyle(
                          color: item.isSelected ? primaryWhite : primaryAmber,
                          fontWeight: item.isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: item.isSelected,
                      side: BorderSide(
                        width: .9,
                        color: primaryAmber, // Cor da borda
                      ),
                      selectedColor: primaryAmber,
                      checkmarkColor: primaryWhite,
                      backgroundColor: primaryWhite,
                      onSelected: (bool selected) {
                        setState(() {
                          item.isSelected = selected;
                          if (item.isSelected) {
                            widget.CategorysIds.add(item.id!);
                            // Corrigido aqui
                          } else {
                            widget.CategorysIds.remove(item.id);
                          }

                          print(widget.CategorysIds.toList());
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ShimmerCategory extends StatelessWidget {
  const ShimmerCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          child: SizedBox(
            child: GlobalShimmer(
              shimmerWidth: 0,
              shimmerHeight: 40,
              border: 8,
            ),
          ),
        );
      },
    );
  }
}

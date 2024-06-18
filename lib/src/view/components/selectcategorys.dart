import 'package:app_receitas_mobile/src/view/components/globalshimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/categoryController.dart';
import '../styles/colores.dart';

class SelectCategory extends StatefulWidget {
  final List<int> CategorysIds;
  final String? Function(String? value) validator; // Correção aqui

  const SelectCategory({
    Key? key,
    required this.CategorysIds,
    required this.validator,
  }) : super(key: key);

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  late CategoryController categories;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    categories = Provider.of<CategoryController>(context);
    return categories.isLoading
        ? ShimmerCategory()
        : Wrap(
          spacing: 10,
          runSpacing: 0.0,
          children: categories.listCategories.map((item) {
            return ChoiceChip(
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
                  if (selected) {
                    if (!widget.CategorysIds.contains(item.id)) {
                      widget.CategorysIds.add(item.id!);
                    }
                  } else {
                    widget.CategorysIds.remove(item.id);
                  }
            
                  print(widget.CategorysIds.toList());
                });
              },
            );
          }).toList(),
        );
  }
}

class ShimmerCategory extends StatelessWidget {
  const ShimmerCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          child: SizedBox(
            width: (MediaQuery.of(context).size.width / 3) - 16,
            child: GlobalShimmer(
              shimmerWidth: 0,
              shimmerHeight: 40,
              border: 8,
            ),
          ),
        );
      }),
    );
  }
}

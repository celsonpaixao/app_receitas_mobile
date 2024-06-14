import 'dart:collection';
import 'package:app_receitas_mobile/src/model/categoryModel.dart';
import 'package:app_receitas_mobile/src/repository/categoryRepository.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  List<CategoryModel> _listCategories = [];
  UnmodifiableListView<CategoryModel> get listCategories =>
      UnmodifiableListView(_listCategories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getCategoryList() async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await CategoryRepository().getCategories();
      _listCategories = [
        CategoryModel(id: 0, name: "Todos"), // Add the "Todos" category
        ...response
      ];
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that the loading state and data have changed
    }
  }
}

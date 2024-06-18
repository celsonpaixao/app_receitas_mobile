import 'dart:collection';
import 'package:app_receitas_mobile/src/model/categoryModel.dart';
import 'package:app_receitas_mobile/src/repository/categoryRepository.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  CategoryRepository repository;
  List<CategoryModel> _listCategories = [];
  UnmodifiableListView<CategoryModel> get listCategories =>
      UnmodifiableListView(_listCategories);

  CategoryController({required this.repository}) {
    getCategoryList();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getCategoryList() async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await repository.getCategories();
      _listCategories = [
        CategoryModel(id: 0, name: "Todos"), // Adiciona a categoria "Todos"
        ...response
      ];
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifica que o estado de carregamento e os dados mudaram
    }
  }
}

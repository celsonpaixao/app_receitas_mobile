import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:app_receitas_mobile/src/model/categoryModel.dart';
import 'package:app_receitas_mobile/src/repository/categoryRepository.dart';

class CategoryController extends ChangeNotifier {
  final CategoryRepository repository;
  List<CategoryModel> _listCategories = [];
  UnmodifiableListView<CategoryModel> get listCategories =>
      UnmodifiableListView(_listCategories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CategoryController({required this.repository}) {
    getCategoryList();
  }

  void getCategoryList() async {
    _isLoading = true;
    notifyListeners();

    var response = await repository.getCategories();

    if (response != null) {
      _listCategories = response;
    } else {
      print('Error fetching categories');
      // Handle error state as needed (e.g., show error message)
    }

    _isLoading = false;
    notifyListeners();
  }
}

import 'package:app_receitas_mobile/src/model/categoryModel.dart';
import 'package:app_receitas_mobile/src/repository/categoryRepository.dart';

class CategoryController {
  Future<List<CategoryModel>> getCategoryList() async {
    return CategoryRepository().getCategorys();
  }
}

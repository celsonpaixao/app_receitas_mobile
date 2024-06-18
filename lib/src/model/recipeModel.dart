import 'package:app_receitas_mobile/src/model/ratingModel.dart';

class RecipeModel {
  final int? id;
  final String? title;
  final String? description;
  final String? instructions;
  final String? imageURL;
  final String? admin;
  final List<String>? categorias;
  final List<String>? ingredients;
  final List<String>? materials;
  final List<RatingModel>?
      avaliacoes; // Assuming RatingModel is defined elsewhere

  RecipeModel({
    this.id,
    this.title,
    this.description,
    this.instructions,
    this.imageURL,
    this.admin,
    this.categorias,
    this.ingredients,
    this.materials,
    this.avaliacoes,
  });

  // JSON deserialization
  RecipeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        instructions = json['instructions'],
        imageURL = json['imageURL'],
        admin = json['admin'],
        categorias = List<String>.from(json['categorias'] ?? []),
        ingredients = List<String>.from(json['ingredients'] ?? []),
        materials = List<String>.from(json['materials'] ?? []),
        avaliacoes = (json['avaliacoes'] as List<dynamic>?)
            ?.map((e) => RatingModel.fromJson(e as Map<String, dynamic>))
            .toList();

  // JSON serialization
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['instructions'] = instructions;
    data['imageURL'] = imageURL;
    data['admin'] = admin;
    data['categorias'] = categorias;
    data['ingredients'] = ingredients;
    data['materials'] = materials;
    data['avaliacoes'] = avaliacoes?.map((e) => e.toJson()).toList();
    return data;
  }

  // Calculate average rating
  double? calculateAverageRating() {
    if (avaliacoes == null || avaliacoes!.isEmpty) {
      return null;
    }
    double totalRating = 0.0;
    for (var avaliacao in avaliacoes!) {
      totalRating += avaliacao.value ?? 0.0;
    }
    return totalRating / avaliacoes!.length;
  }
}

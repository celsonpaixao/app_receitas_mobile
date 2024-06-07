import 'package:app_receitas_mobile/src/model/ratingModel.dart';

class RecipeModel {
  int? id;
  String? title;
  String? description;
  String? instructions;
  String? imageURL;
  String? admin;
  List<String>? categorias;
  List<String>? ingredients;
  List<String>? materials;
  List<RatingModel>? avaliacoes;

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

  RecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    instructions = json['instructions'];
    imageURL = json['imageURL'];
    admin = json['admin'];
    categorias = List<String>.from(json['categorias']);
    ingredients = List<String>.from(json['ingredients']);
    materials = List<String>.from(json['materials']);
    if (json['avaliacoes'] != null) {
      avaliacoes = <RatingModel>[];
      json['avaliacoes'].forEach((v) {
        avaliacoes!.add(RatingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['instructions'] = this.instructions;
    data['imageURL'] = this.imageURL;
    data['admin'] = this.admin;
    data['categorias'] = this.categorias;
    data['ingredients'] = this.ingredients;
    data['materials'] = this.materials;
    if (this.avaliacoes != null) {
      data['avaliacoes'] = this.avaliacoes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

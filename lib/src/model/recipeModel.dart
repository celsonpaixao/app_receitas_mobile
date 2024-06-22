class RecipeModel {
  int? id;
  String? title;
  String? description;
  String? instructions;
  String? imageURL;
  int? idAdmin;
  String? admin;
  List<String>? categorias;
  List<String>? ingredients;
  List<String>? materials;
  double? averageRating;

  RecipeModel(
      {this.id,
      this.title,
      this.description,
      this.instructions,
      this.imageURL,
      this.idAdmin,
      this.admin,
      this.categorias,
      this.ingredients,
      this.materials,
      this.averageRating});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    instructions = json['instructions'];
    imageURL = json['imageURL'];
    idAdmin = json['idAdmin'];
    admin = json['admin'];
    categorias = json['categorias'].cast<String>();
    ingredients = json['ingredients'].cast<String>();
    materials = json['materials'].cast<String>();
      averageRating = json['averageRating']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['instructions'] = instructions;
    data['imageURL'] = imageURL;
    data['idAdmin'] = idAdmin;
    data['admin'] = admin;
    data['categorias'] = categorias;
    data['ingredients'] = ingredients;
    data['materials'] = materials;
    data['averageRating'] = averageRating;
    return data;
  }
}

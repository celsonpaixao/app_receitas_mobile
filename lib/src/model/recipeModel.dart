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
        materials = List<String>.from(json['materials'] ?? []);

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
    return data;
  }


}

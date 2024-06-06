class CategoryModel {
  int? id;
  String? name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

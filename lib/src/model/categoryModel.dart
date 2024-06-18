class CategoryModel {
  final int? id;
  final String? name;
  bool isSelected; // Remova 'final' aqui

  CategoryModel({
    required this.id,
    required this.name,
    this.isSelected = false, // Não é mais 'final'
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        isSelected = false;

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

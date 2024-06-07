
class CategoryModel {
  int? id;
  String? name;
  late bool isSelected; // Adicione a propriedade isSelected aqui

  CategoryModel({
    required this.id,
    required this.name,
    this.isSelected = false, // Valor padrão é falso
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        isSelected = false; // Inicialize isSelected como false

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

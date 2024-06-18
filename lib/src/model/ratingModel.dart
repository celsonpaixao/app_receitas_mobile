import 'package:app_receitas_mobile/src/model/userModel.dart';

class RatingModel {
  final int? id;
  final double? value;
  final String? message;
  final UserModel? user;

  RatingModel({this.id, this.value, this.message, this.user});

  RatingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value']?.toDouble(), // Convertendo para double
        message = json['message'],
        user = json['user'] != null ? UserModel.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['message'] = message;
     data['user'] = user!.toJson();
    return data;
  }
}

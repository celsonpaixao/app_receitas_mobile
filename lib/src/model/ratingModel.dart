import 'package:app_receitas_mobile/src/model/userModel.dart';

class RatingModel {
  final int? id;
  final double? value;
  final String? message;
  final UserModel? user;

  RatingModel({this.id, this.value, this.message, this.user});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['ratingId'],
      value: json['rating']['value']?.toDouble(),
      message: json['rating']['message'],
      user: json['rating']['user'] != null
          ? UserModel.fromJson(json['rating']['user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['value'] = value;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

import 'package:app_receitas_mobile/src/model/userModel.dart';

class RatingModel {
  int? id;
  double? value;
  String? message;
  UserModel? user;

  RatingModel({this.id, this.value, this.message, this.user});

  RatingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    message = json['message'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

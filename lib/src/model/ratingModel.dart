import 'package:app_receitas_mobile/src/model/userModel.dart';

class RatingModel {
  final int? id;
  final double? value;
  final String? message;
  final UserModel? user;

  RatingModel({this.id, this.value, this.message, this.user});

  RatingModel.fromJson(Map<String, dynamic> json)
      : id = json['rating']['id'],
        value = json['rating']['value']?.toDouble(),
        message = json['rating']['message'],
        user = json['rating']['user'] != null
            ? UserModel.fromJson(json['rating']['user'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }



   double? calculateAverageRating(List<RatingModel> ratings) {
    if (ratings.isEmpty) {
      return null;
    }
    double totalRating = 0.0;
    for (var rating in ratings) {
      totalRating += rating.value ?? 0.0;
    }
    return totalRating / ratings.length;
  }
}

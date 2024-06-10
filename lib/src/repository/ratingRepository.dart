import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../DTO/DTOresponse.dart';
import '../model/ratingModel.dart';

class RatingRepository {
  static final String baseUrl = baseUrl;

  Future<DTOresponse> publicaRating(
      int userId, int recipeId, RatingModel rating) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("auth_token");

    if (token == null) {
      return DTOresponse(success: false, message: 'Token not found');
    }

    final url = Uri.parse(
        "$baseUrl/api/Rating/public_avaliaction?id_receita=$recipeId&id_user=$userId");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(rating.toJson()),
      );

      print(response.body);

      if (response.statusCode == 200) {
        var message = json.decode(response.body)['message'];
        return DTOresponse(success: true, message: message);
      } else {
        return DTOresponse(success: false, message: 'Failed to publish rating');
      }
    } catch (e) {
      print(e);
      return DTOresponse(success: false, message: 'An error occurred');
    }
  }
}

import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserModel> decodeUser() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("auth_token");

  if (token != null) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    final String id = decodedToken['userid'];
    final String firstName = decodedToken['firstname'];
    final String lastName = decodedToken['lastname'];
    final String email = decodedToken['useremail'];
    final String imageURL = decodedToken['imageurl'];
    print(firstName);
    
    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: '', // Adicione uma senha padrão ou nula se necessário
      imageURL: imageURL,
    );
  } else {
    throw Exception('Token not found in SharedPreferences');
  }
}

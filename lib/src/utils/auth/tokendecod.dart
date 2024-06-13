import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserToken {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageURL;
  final String? password; // Adicione uma senha padrão ou nula se necessário

  UserToken({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageURL,
    this.password, 
  });
}

Future<UserToken> decodeUser() async {
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

    return UserToken(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      imageURL: imageURL,
      password: null, // Adicione uma senha padrão ou nula se necessário
    );
  } else {
    throw Exception('Token not found in SharedPreferences');
  }
}

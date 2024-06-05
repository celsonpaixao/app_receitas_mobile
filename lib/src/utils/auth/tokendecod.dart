import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Object> decodeUser() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("auth_token");

  if (token != null) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    final String Id = decodedToken['userid'];
    final String firstName = decodedToken['firstname'];
    final String lastName = decodedToken['lastname'];
    final String email = decodedToken['useremail'];
    final String imageURL = decodedToken['imageurl'];
    print(firstName);
    return (
      id: Id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      imageURL: imageURL,
    );
  } else {
    throw Exception('Token not found in SharedPreferences');
  }
}

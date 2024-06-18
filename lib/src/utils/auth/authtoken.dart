import 'package:shared_preferences/shared_preferences.dart';

Future<bool> AuthToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("auth_token");
  if (token != null) {
    print("SEU TOKEN DE ACESSO É : $token");
    return true;
  } else {
    return false;
  }
}

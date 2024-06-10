import 'package:shared_preferences/shared_preferences.dart';

Future<bool> AuthToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("auth_token") != null) {
    return true;
  } else {
    return false;
  }
}

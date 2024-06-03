import 'package:shared_preferences/shared_preferences.dart';

AuthToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("token") != null) {
    return true;
  } else {
    return false;
  }
}

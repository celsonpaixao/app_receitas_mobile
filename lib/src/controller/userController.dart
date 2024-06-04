import 'package:app_receitas_mobile/src/repository/userRepository.dart';

class UserController {
  Future<String> LoginUser(String email, String password) async {
    return AuthUser(email, password);
  }
}

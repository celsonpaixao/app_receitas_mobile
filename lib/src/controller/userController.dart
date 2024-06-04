import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/repository/userRepository.dart';

class UserController {
  Future<String> LoginUser(String email, String password) async {
    return UserRespository().AuthUser(email, password);
  }

  Future<String> JoinUsUser(UserModel user, String confirm_password) async {
    return UserRespository().RegisterUser(user, confirm_password);
  }
}

import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/repository/userRepository.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  Future<DTOresponse> LoginUser(String email, String password) async {
    return UserRespository().AuthUser(email, password);
  }

  Future<DTOresponse> JoinUsUser(
      UserModel user, String confirm_password) async {
    return UserRespository().RegisterUser(user, confirm_password);
  }
}

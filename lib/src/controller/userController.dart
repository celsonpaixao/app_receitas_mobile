import 'dart:io';

import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/repository/userRepository.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserRepository repository;

  UserController({required this.repository});

  Future<DTOresponse> loginUser(String email, String password) async {
    return repository.authUser(email, password);
  }

  Future<bool> logoutUser(BuildContext context) async {
    var response = await repository.logout();
    return response;
  }

  Future<DTOresponse> joinUsUser(
      UserModel user, String confirm_password) async {
    return repository.registerUser(user, confirm_password);
  }

  Future<DTOresponse> updateUser(
    int id,
    String firstName,
    String lastName,
    String email,
    String password,
    String confirmPassword,
    File image,
  ) async {
    return repository.updateUser(
      userId: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
      confirmPassword: confirmPassword,
      image: image,
    );
  }
}

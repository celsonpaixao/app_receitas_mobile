import 'dart:io';

import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/repository/userRepository.dart';

import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserRepository repository;

  UserController({required this.repository});

  Future<DTOresponse> loginUser(String email, String password) async {
    return repository.authUser(email, password);
  }

  Future<bool> logoutUser() async {
    return await repository.logout();
  }

  Future<DTOresponse> joinUsUser(
      UserModel user, String confirm_password) async {
    return repository.registerUser(user, confirm_password);
  }

  Future<DTOresponse> deletUser(int idUser) async {
    return await repository.deleteUser(idUser);
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

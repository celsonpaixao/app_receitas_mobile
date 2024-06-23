import 'dart:async';

import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/filters/messagefilter.dart';

class UserRepository {
  static String baseurl = baseUrl;

  Future<DTOresponse> authUser(String email, String password) async {
    var url = Uri.parse(
        "$baseurl/api/User/auth_user?email=$email&password=$password");

    try {
      print('Enviando solicitação de autenticação...');
      print('Email: $email');

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      print('Resposta recebida: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String token = data['response']['token'];
        final String message = data['message'];
        print(message);
        print('Token de autenticação recebido: $token');
        return DTOresponse(
          success: true,
          message: message,
          token: token,
        );
      } else {
        final responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['message'] ?? 'Unknown error';
        print('Falha na autenticação: ${response.statusCode}, $errorMessage');
        return DTOresponse(success: false, message: errorMessage);
      }
    } catch (e) {
      print('Erro ao autenticar usuário: $e');
      return DTOresponse(
        success: false,
        message: parseErrorMessage(
          e.toString(),
        ),
      );
    }
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    final String? token = sharedPreferences.getString("auth_token");

    if (token == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<DTOresponse> registerUser(
    UserModel user,
    String confirmPassword,
  ) async {
    var url = Uri.parse(
        "$baseurl/api/User/register_user?firstName=${user.firstName}&lastName=${user.lastName}&email=${user.email}&password=${user.password}&confirmPassword=$confirmPassword");

    try {
      print(
          "${user.email}, ${user.firstName}, ${user.lastName}, ${user.password}");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      print('Resposta recebida: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String message = data['message'];
        return DTOresponse(success: true, message: message);
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = errorData.toString();
        return DTOresponse(success: false, message: errorMessage);
      }
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      return DTOresponse(
        success: false,
        message: parseErrorMessage(
          e.toString(),
        ),
      );
    }
  }

  Future<DTOresponse> updateUser({
    required int userId,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      var url = Uri.parse(
          '$baseurl/api/User/update_user?id=$userId&confirmpassword=$confirmPassword');

      var request = http.MultipartRequest('PUT', url);
      request.fields['First_Name'] = firstName;
      request.fields['Last_Name'] = lastName;
      request.fields['Email'] = email;
      request.fields['Password'] = password;

      // Adicionar imagem como arquivo
      String fileName = image.path.split('/').last;
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: fileName,
      ));

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? token = sharedPreferences.getString("auth_token");

      if (token == null) {
        throw Exception('Token not found in SharedPreferences');
      }

      // Adicionar header de autorização
      request.headers['Authorization'] = 'Bearer $token';

      // Enviar a requisição e aguardar a resposta
      final response = await request.send();

      print('Resposta recebida: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(await response.stream.bytesToString());

        final String newToken = responseData['response']['token'];
        print("O novo token é : $newToken");
        await sharedPreferences.setString("auth_token", newToken);

        // Obter a mensagem de sucesso da resposta
        String message =
            responseData['message'] ?? 'User updated successfully!';

        print('Atualização do usuário bem-sucedida: $message');
        return DTOresponse(
          success: true,
          message: message,
          token: newToken,
        );
      } else {
        final Map<String, dynamic> errorData =
            jsonDecode(await response.stream.bytesToString());
        String errorMessage = errorData['message'] ?? 'Erro desconhecido';
        print(
            'Falha na atualização do usuário: ${response.statusCode}, $errorMessage');
        return DTOresponse(success: false, message: errorMessage);
      }
    } catch (e) {
      print('Erro ao atualizar usuário: $e');
      return DTOresponse(success: false, message: "$e");
    }
  }
}

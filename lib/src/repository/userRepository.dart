import 'dart:async';
import 'dart:convert';
import 'package:app_receitas_mobile/src/DTO/DTOresponse.dart';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:http/http.dart' as http;

class UserRespository {
  static String baseurl = baseUrl;

  Future<DTOresponse> AuthUser(String email, String password) async {
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
          success: false, message: _parseErrorMessage(e.toString()));
    }
  }

  Future<DTOresponse> RegisterUser(
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
          success: false, message: _parseErrorMessage(e.toString()));
    }
  }

  String _parseErrorMessage(String error) {
    if (error.contains("This user does not exist")) {
      return "Este usuário não existe !!";
    } else if (error.contains("Incorrect password")) {
      return "Senha incorreta !!";
    } else if (error.contains(
        "CERTIFICATE_VERIFY_FAILED: self signed certificate(handshake.cc:393))")) {
      return "Sem Internet !!";
    } else if (error.contains("User already exists with this email!")) {
      return "Este E-mail está a ser utilizado";
    } else if (error
        .contains("Password and password confirmation do not match!")) {
      return "A senha e a confirmação da senha não coincidem!";
    } else {
      return error;
    }
  }
}

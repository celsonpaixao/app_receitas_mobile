import 'dart:async';
import 'dart:convert';
import 'package:app_receitas_mobile/src/model/userModel.dart';
import 'package:app_receitas_mobile/src/utils/api/apicontext.dart';
import 'package:http/http.dart' as http;

class UserRespository {
  static String baseurl = baseUrl;

  Future<String> AuthUser(String email, String password) async {
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
        print('Token de autenticação recebido: $token');
        return token;
      } else {
        final responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['message'] ?? 'Unknown error';
        print('Falha na autenticação: ${response.statusCode}, $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Log any exceptions
      print('Erro ao autenticar usuário: $e');
      throw Exception(_parseErrorMessage(e.toString()));
    }
  }

  Future<String> RegisterUser(
    UserModel user,
    String confitm_password,
  ) async {
    var url = Uri.parse(
        "$baseurl/api/User/register_user?confirmpassword=$confitm_password");

     try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': ' multipart/form-data',
        },
        body: jsonEncode(<String, String>{
          'First_Name': user.first_name,
          'Last_Name': user.last_aame,
          'Email': user.email,
          'Password': user.password,
          
        }),
      );

      print('Resposta recebida: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String message = data['response']['message'];
        return message;
      } else {
        final responseBody = jsonDecode(response.body);
        String errorMessage = responseBody.toString();
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      throw Exception(_parseErrorMessage(e.toString()));
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

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> AuthUser(String email, String password) async {
  var url = Uri.parse(
      "https://pb950tcj-5223.euw.devtunnels.ms/api/User/auth_user?email=$email&password=$password");

  try {
    print('Enviando solicitação de autenticação...');
    print('Email: $email, Senha: $password');

    final response = await http.post(url);
    print(url);
    print('Resposta recebida: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Parse the JSON response and directly access the token
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String token = data['response']['token'];
      print('Token de autenticação recebido: $token');
      return token;
    } else {
      // Handle other status codes or errors by getting the response body
      final responseBody = response.body;
      print('Falha na autenticação: ${response.statusCode}, $responseBody');
      throw Exception(responseBody);
    }
  } catch (e) {
    // Log any exceptions
    print('Erro ao autenticar usuário: $e');
    throw Exception(e);
  }
}

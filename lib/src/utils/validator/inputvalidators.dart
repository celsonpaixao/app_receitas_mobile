// src/utils/validators.dart
class InputValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "É necessário informar o E-mail para prosseguir";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "E-mail inválido";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "É necessário informar a senha para prosseguir";
    }
    if (value.length < 6) {
      return "A senha deve ter pelo menos 6 caracteres";
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "É necessário informar o nome para prosseguir";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "É necessário confirmar a senha";
    }
    if (password != confirmPassword) {
      return "As senhas não coincidem";
    }
    return null;
  }
}

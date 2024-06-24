String filterMessage(String theMessage) {
  if (theMessage.contains("This user does not exist")) {
    return "Este usuário não existe !!🤷‍♂️🤷‍♂️🤷‍♂️";
  } else if (theMessage.contains("Incorrect password")) {
    return "Senha incorreta !!🤦‍♀️🤦‍♀️";
  } else if (theMessage.contains(
    "CERTIFICATE_VERIFY_FAILED: self signed certificate(handshake.cc:393))",
  )) {
    return "Sem Internet !!";
  } else if (theMessage.contains("User already exists with this email!")) {
    return "Este E-mail está a ser utilizado..!!😢😢";
  } else if (theMessage
      .contains("Password and password confirmation do not match!")) {
    return "A senha e a confirmação da senha não coincidem!..🙄🙄";
  } else if (theMessage.contains("User Auth success")) {
    return "Login com sucesso...! 👌👌";
  } else if (theMessage.contains("User updated successfully!")) {
    return "Usuário Atuário Atualizado com sucesso...! 👌👌";
  } else if (theMessage.contains("User registered successfully!")) {
    return "Usuário Cadastrado com sucesso...! 👌👌";
  } else if (theMessage.contains("User deleted successfully")) {
    return "Usuário Deletado com sucesso...!";
  } else {
    return theMessage;
  }
}

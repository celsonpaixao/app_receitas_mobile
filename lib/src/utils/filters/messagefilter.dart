String parseErrorMessage(String error) {
  if (error.contains("This user does not exist")) {
    return "Este usuário não existe !!🤷‍♂️🤷‍♂️🤷‍♂️";
  } else if (error.contains("Incorrect password")) {
    return "Senha incorreta !!🤦‍♀️🤦‍♀️";
  } else if (error.contains(
    "CERTIFICATE_VERIFY_FAILED: self signed certificate(handshake.cc:393))",
  )) {
    return "Sem Internet !!";
  } else if (error.contains("User already exists with this email!")) {
    return "Este E-mail está a ser utilizado..!!😢😢";
  } else if (error
      .contains("Password and password confirmation do not match!")) {
    return "A senha e a confirmação da senha não coincidem!..🙄🙄";
  } else if (error.contains("User Auth success")) {
    return "Login com sucesso...! 👌👌";
  } else {
    return error;
  }
}

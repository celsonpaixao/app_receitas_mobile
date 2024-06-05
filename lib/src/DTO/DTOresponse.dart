class DTOresponse {
  final bool success;
  final String message;
  final String? token;

  DTOresponse(
      {required this.success, required this.message, this.token});

  factory DTOresponse.fromJson(Map<String, dynamic> json) {
    return DTOresponse(
      success: json['success'],
      message: json['message'],
      token: json['token'],
    );
  }
}

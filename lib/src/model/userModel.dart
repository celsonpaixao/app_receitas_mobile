class UserModel {
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String? imageurl;

  UserModel(
      {required this.first_name,
      required this.last_name,
      required this.email,
      required this.password,
       this.imageurl});
}

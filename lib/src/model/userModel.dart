class UserModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? imageURL;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.imageURL,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_Name'],
        lastName = json['last_Name'],
        email = json['email'],
        password = json['password'],
        imageURL = json['imageURL'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_Name': firstName,
        'last_Name': lastName,
        'email': email,
        'password': password,
        'imageURL': imageURL,
      };
}

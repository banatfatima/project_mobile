class UserModel {
  late int id;
  late String name;
  late String email;
  late String password;

  UserModel({        
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
}
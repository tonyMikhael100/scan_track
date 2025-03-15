class UserModel {
  final int id;
  final String username;
  final String password;
  final int userControl;

  UserModel(
      {required this.id,
      required this.username,
      required this.password,
      required this.userControl});

  factory UserModel.toJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      userControl: json['user_control'],
    );
  }
}

import 'package:simple_e_commerce/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userName,
    required super.email,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json['userName'],
    email: json['email'],
    role: json['role'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['userName'] = userName;
    data['role'] = role;
    return data;
  }
}

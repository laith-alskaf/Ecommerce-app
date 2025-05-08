class UserModel {
  String? id;
  String? userName;
  String? email;
  String? password;
  String? role;

  UserModel({this.userName, this.email, this.password, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id:
    json['id'];
    userName:
    json['userName'];
    email:
    json['email'];
    password:
    json['password'];
    role:
    json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['password'] = password;
    data['userName'] = userName;
    data['role'] = role;
    return data;
  }
}

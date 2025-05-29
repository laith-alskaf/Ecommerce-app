
class UserModel {
  String? userName;
  String? email;
  String? role;

  UserModel({this.userName, this.email, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['userName'] = userName;
    data['role'] = role;
    return data;
  }
}

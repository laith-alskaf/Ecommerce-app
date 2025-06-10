import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String userName;
  final String email;
  final String password;
  final String role;

  const SignUpParams({
    required this.userName,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [userName, email, role];
}

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userName;
  final String email;
  final String role;

  const UserEntity({
    required this.userName,
    required this.email,
    required this.role,
  });

  @override
  List<Object?> get props => [userName, email, role];
}

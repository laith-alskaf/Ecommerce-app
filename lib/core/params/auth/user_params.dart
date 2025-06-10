import 'package:equatable/equatable.dart';

class UserParams extends Equatable {
  final String email;
  final String name;

  const UserParams({required this.email, required this.name});

  @override
  List<Object?> get props => [name, email];
}

import 'package:equatable/equatable.dart';

class VerifyParams extends Equatable {
  final String email;

  const VerifyParams({required this.email});

  @override
  List<Object?> get props => [email];
}

part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class ToggleShowPassState extends LoginState {
  final bool showPass;
  const ToggleShowPassState({required this.showPass});

  @override
  List<Object> get props => [showPass];
}

final class LoginInitial extends LoginState {}

class LoginInLoading extends LoginState {}

class LoginInSuccess extends LoginState {
  final UserEntity user;
  const LoginInSuccess({required this.user});
}

class LoginInError extends LoginState {
  final String message;
  const LoginInError({required this.message});
}

class LoginAsGuest extends LoginState {}

part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

//ForogtPassword
final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  const ForgotPasswordSuccess({required this.message});
}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  const ForgotPasswordError({required this.message});
}

//SendCode
final class SendCodeInitial extends ForgotPasswordState {}

final class SendCodeLoading extends ForgotPasswordState {}

class SendCodeSuccess extends ForgotPasswordState {
  final String message;
  const SendCodeSuccess({required this.message});
}

class SendCodeError extends ForgotPasswordState {
  final String message;
  const SendCodeError({required this.message});
}

//ResetPasswrod
final class ResetPasswrodInitial extends ForgotPasswordState {}

final class ResetPasswrodLoading extends ForgotPasswordState {}

class ResetPasswrodSuccess extends ForgotPasswordState {
  final String message;
  const ResetPasswrodSuccess({required this.message});
}

class ResetPasswrodError extends ForgotPasswordState {
  final String message;
  const ResetPasswrodError({required this.message});
}

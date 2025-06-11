part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  final String role;
  final List<bool> expandedList;

  const SignUpState({
    this.role = 'customer',
    this.expandedList = const [false, false],
  });

  @override
  List<Object> get props => [role, expandedList];

  SignUpState copyWith({String? role, List<bool>? expandedList}) {
    return SignUpState(
      role: role ?? this.role,
      expandedList: expandedList ?? this.expandedList,
    );
  }
}

//SignUp
class SignUpInitial extends SignUpState {}

final class ToggleShowPassState extends SignUpState {
  final bool showPass;
  final bool showConfirmPass;

  const ToggleShowPassState({
    this.showPass = true,
    this.showConfirmPass = true,
  });

  @override
  List<Object> get props => [showPass, showConfirmPass];
}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;

  const SignUpSuccess({required this.message});
}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError({required this.message});
}

//Verify
class VerifyInitial extends SignUpState {}

class VerifyLoading extends SignUpState {}

class VerifySuccess extends SignUpState {
  final String message;

  const VerifySuccess({required this.message});
}

class VerifyError extends SignUpState {
  final String message;

  const VerifyError({required this.message});
}

//SendCode
class SendCodeInitial extends SignUpState {}

class SendCodeLoading extends SignUpState {}

class SendCodeSuccess extends SignUpState {
  final String message;

  const SendCodeSuccess({required this.message});
}

class SendCodeError extends SignUpState {
  final String message;

  const SendCodeError({required this.message});
}

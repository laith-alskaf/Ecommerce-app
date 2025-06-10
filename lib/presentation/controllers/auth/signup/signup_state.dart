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
  showToastMessageSUCCESS(String message) {
    CustomToast.showMessage(message: message, messageType: MessageType.SUCCESS);
  }

  showToastMessageError(String message) {
    CustomToast.showMessage(
      message: message,
      messageType: MessageType.REJECTED,
    );
  }

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
  SignUpSuccess({required this.message}) {
    super.showToastMessageSUCCESS(message);
  }
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError({required this.message}) {
    super.showToastMessageError(message);
  }
}

//Verify
class VerifyInitial extends SignUpState {}

class VerifyLoading extends SignUpState {}

class VerifySuccess extends SignUpState {
  final String message;
  VerifySuccess({required this.message}) {
    super.showToastMessageSUCCESS(message);
  }
}

class VerifyError extends SignUpState {
  final String message;
  VerifyError({required this.message}) {
    super.showToastMessageError(message);
  }
}

//SendCode
class SendCodeInitial extends SignUpState {}

class SendCodeLoading extends SignUpState {}

class SendCodeSuccess extends SignUpState {
  final String message;
  SendCodeSuccess({required this.message}) {
    super.showToastMessageSUCCESS(message);
  }
}

class SendCodeError extends SignUpState {
  final String message;
  SendCodeError({required this.message}) {
    super.showToastMessageError(message);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/presentation/controllers/auth/signup/signup_cubit.dart';

mixin SignUpProviders on Cubit<SignUpState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  String selectedRole = 'customer';
  int currentIndex = 0;
  List<String> imageSignUp = ['verfiy', 'emailcheck', 'right'];
  List<bool> hidePasswordList = [true, true];
  late String email;
  List<bool> expandedContainer = [false, false];

  void clickToExpanded({required int index}) {
    final newExpanded = List<bool>.from(expandedContainer);
    newExpanded[index] = !newExpanded[index];
    expandedContainer = newExpanded;
    emit(state.copyWith(expandedList: newExpanded));
  }

  Future selectRole({required String role}) async {
    selectedRole = role;
    expandedContainer[0] = false;
    expandedContainer[1] = false;
    emit(state.copyWith(expandedList: expandedContainer, role: role));
    await Future.delayed(Duration(milliseconds: 300), () {
      if (role == 'admin') {
        expandedContainer[1] = true;
        emit(state.copyWith(expandedList: [false, true]));
      } else {
        expandedContainer[0] = true;
        emit(state.copyWith(expandedList: [true, false]));
      }
    });
  }

  void toggleShowPass({required int index}) {
    final newExpanded = List<bool>.from(hidePasswordList);
    hidePasswordList[index] = !hidePasswordList[index];
    newExpanded[index] = !newExpanded[index];
    emit(
      ToggleShowPassState(
        showPass: newExpanded[0],
        showConfirmPass: newExpanded[1],
      ),
    );
  }

  void clearSignUpControllers() {
    emailController.clear();
    passwordController.clear();
    verifyCodeController.clear();
    confirmController.clear();
    firstNameController.clear();
    lastNameController.clear();
    companyNameController.clear();
    companyAddressController.clear();
    companyDescriptionController.clear();
  }
}

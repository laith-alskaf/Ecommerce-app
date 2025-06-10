import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';

part 'my_app_state.dart';

class MyAppCubit extends Cubit<MyAppState> {
  late String role;

  MyAppCubit() : super(MyAppInitial()) {
    initAppRout();
  }

  initAppRout() {
    role = sl<SharedPreferenceRepositories>().getRole();
    emit(state.copyWith(role: role));
  }

  bool hasPermissionToUse() {
    if (role == 'guest') {
      // showLoginRequiredDialog(
      //   message:
      //   "To use this feature and access all app services, please log in or create a new account.",
      //   onLoginPressed: () {
      //     Get.back();
      //     storage.clearPreference();
      //     Get.offAll(() => LoginView());
      //   },
      //   onSignUpPressed: () {
      //     Get.back();
      //     storage.clearPreference();
      //     Get.offAll(() => SignUpMain());
      //   },
      // );
      emit(HasNotPermission());
      emit(MyAppInitial());
      return false;
    } else {
      emit(HasPermission());
      emit(MyAppInitial());
      return true;
    }
  }
}

part of 'my_app_cubit.dart';

class MyAppState extends Equatable {
  final String role;

  const MyAppState({this.role = 'NAN'});

  MyAppState copyWith({required String role}) {
    return MyAppState(role: role);
  }

  @override
  List<Object> get props => [role];
}

final class MyAppInitial extends MyAppState {}

final class HasPermission extends MyAppState {}

final class HasNotPermission extends MyAppState {}

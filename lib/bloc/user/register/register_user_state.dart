part of 'register_user_bloc.dart';

@immutable
sealed class RegisterUserState {}

class RegisterUserInitial extends RegisterUserState {}

class RegisterUserLoading extends RegisterUserState {}

class RegisterUserSuccess extends RegisterUserState {
  final UserRegisterResponse response;
  RegisterUserSuccess({required this.response});
}

class RegisterUserError extends RegisterUserState {
  final UserRegisterResponse response;
  // final String message;
  RegisterUserError({required this.response});
}

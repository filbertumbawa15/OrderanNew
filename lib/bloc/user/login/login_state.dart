part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserRegisterResponse response;
  LoginSuccess({required this.response});
}

final class LoginError extends LoginState {
  final UserRegisterResponse response;
  LoginError({required this.response});
}

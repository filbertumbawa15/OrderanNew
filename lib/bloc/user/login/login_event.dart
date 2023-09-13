part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  String email;
  String password;

  LoginUserEvent({
    required this.email,
    required this.password,
  });
}

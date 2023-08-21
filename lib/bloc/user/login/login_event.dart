part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  String email;
  String password;

  LoginUserEvent({
    required this.email,
    required this.password,
  });
}

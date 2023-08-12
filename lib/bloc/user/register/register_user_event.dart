part of 'register_user_bloc.dart';

@immutable
sealed class RegisterUserEvent {}

class CreateUserEvent extends RegisterUserEvent {
  String name;
  String phone;
  String email;
  String password;
  String sendOTPVia;

  CreateUserEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.sendOTPVia,
  });
}

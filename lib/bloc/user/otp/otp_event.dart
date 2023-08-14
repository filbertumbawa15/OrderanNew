part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class OtpResendEvent extends OtpEvent {
  String email;

  OtpResendEvent({
    required this.email,
  });
}

class CheckOtpEvent extends OtpEvent {
  String otp;
  String identifier;

  CheckOtpEvent({required this.otp, required this.identifier});
}

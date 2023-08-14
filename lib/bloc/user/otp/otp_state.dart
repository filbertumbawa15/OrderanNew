part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpResendLoading extends OtpState {}

final class OtpResendSuccess extends OtpState {}

final class OtpResendError extends OtpState {
  final String message;
  OtpResendError({required this.message});
}

final class OtpLoading extends OtpState {}

final class OtpSuccess extends OtpState {}

final class OtpError extends OtpState {
  final String message;
  OtpError({required this.message});
}

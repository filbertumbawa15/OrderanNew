part of 'otp_resend_cubit.dart';

@immutable
sealed class OtpResendState {}

final class OtpResendInitial extends OtpResendState {}

class OtpResendLoading extends OtpResendState {}

class OtpResendSuccess extends OtpResendState {
  final String message;
  OtpResendSuccess({required this.message});
}

class OtpResendError extends OtpResendState {
  final String message;
  OtpResendError({required this.message});
}

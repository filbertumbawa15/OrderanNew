part of 'forgotpassword_bloc.dart';

sealed class ForgotpasswordState extends Equatable {
  const ForgotpasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotpasswordInitial extends ForgotpasswordState {}

final class ForgotpasswordLoading extends ForgotpasswordState {}

final class ForgotpasswordSuccess extends ForgotpasswordState {
  final ForgotPasswordResponse response;
  const ForgotpasswordSuccess({required this.response});
}

final class ForgotpasswordFailed extends ForgotpasswordState {
  final String message;
  const ForgotpasswordFailed({required this.message});
}

part of 'forgotpassword_bloc.dart';

sealed class ForgotpasswordEvent extends Equatable {
  const ForgotpasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPassEvent extends ForgotpasswordEvent {
  String? email;

  ForgotPassEvent({this.email});
}

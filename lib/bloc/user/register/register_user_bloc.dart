import 'dart:core';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/repo/auth_repository.dart';
import 'package:tasorderan/response/user_response.dart';

part 'register_user_event.dart';
part 'register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  final authRepository = AuthRepository();
  RegisterUserBloc() : super(RegisterUserInitial()) {
    on<CreateUserEvent>(_registerUser);
  }

  void _registerUser(
      CreateUserEvent event, Emitter<RegisterUserState> emit) async {
    UserRegisterResponse response = UserRegisterResponse();
    final params = RegisterUserParam(
      event.name,
      event.phone,
      event.email,
      event.password,
      event.sendOTPVia,
    );
    emit(RegisterUserLoading());
    try {
      response = await authRepository.registerUser(params);
      emit(RegisterUserSuccess(response: response));
    } on UserRegisterResponse catch (_, e) {
      emit(RegisterUserError(response: _));
    }
  }
}

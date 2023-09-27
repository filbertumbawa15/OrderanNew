import 'package:bloc/bloc.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/repo/auth_repository.dart';
import 'package:tasorderan/response/user_response.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final authRepository = AuthRepository();
  final sessionManager = SessionManager();
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(_loginUser);
  }

  void _loginUser(LoginUserEvent event, Emitter<LoginState> emit) async {
    UserRegisterResponse response = UserRegisterResponse();
    final params = LoginParam(
      event.email,
      event.password,
    );
    emit(LoginLoading());
    try {
      response = await authRepository.login(params);
      final ktpPath = await authRepository
          .getKtpImage(response.user?['foto_ktp'] ?? "asdf");
      final npwpPath = await authRepository
          .getnpwpImage(response.user?['foto_npwp'] ?? "asdf");
      sessionManager.setSession(
        response.user!['name'],
        response.user!['user'],
        response.user!['telp'],
        response.user!['id'],
        response.user!['statusverifikasi'],
        response.user!['email'],
        response.user!['name'],
        response.user!['accessToken'],
        ktpPath.path,
        npwpPath.path,
        response.user!['nik'],
        response.user!['no_npwp'],
        response.user!['tgl_lahir'],
      );
      emit(LoginSuccess(response: response));
    } on UserRegisterResponse catch (_) {
      emit(LoginError(response: _));
    }
  }
}

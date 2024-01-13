import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/repo/auth_repository.dart';
import 'package:tasorderan/response/user_response.dart';

part 'forgotpassword_event.dart';
part 'forgotpassword_state.dart';

class ForgotpasswordBloc
    extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {
  final authRepository = AuthRepository();
  final sessionManager = SessionManager();
  final apiClient = ApiClient();
  ForgotpasswordBloc() : super(ForgotpasswordInitial()) {
    on<ForgotPassEvent>(((event, emit) async {
      final params = ForgotPasswordParam(
        event.email,
      );
      emit(ForgotpasswordLoading());
      try {
        final response = await authRepository.forgotPassword(params);
        emit(ForgotpasswordSuccess(response: response));
      } catch (e) {
        emit(ForgotpasswordFailed(message: e.toString()));
      }
    }));
  }
}

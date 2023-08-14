import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/repo/auth_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    final authRepository = AuthRepository();
    on<OtpEvent>(((event, emit) async {
      if (event is OtpResendEvent) {
        emit(OtpResendLoading());
        try {
          final params = OtpResendParam(event.email);
          await authRepository.resend(params);
          emit(OtpResendSuccess());
        } catch (e) {
          emit(OtpResendError(message: e.toString()));
        }
      } else if (event is CheckOtpEvent) {
        emit(OtpLoading());
        try {
          final params = CheckOtpParam(event.otp, event.identifier);
          await authRepository.verifyOtp(params);
          emit(OtpSuccess());
        } catch (e) {
          emit(OtpError(message: e.toString()));
        }
      }
    }));
  }
}

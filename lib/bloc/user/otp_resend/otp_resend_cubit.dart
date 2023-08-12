import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/repo/auth_repository.dart';

part 'otp_resend_state.dart';

class OtpResendCubit extends Cubit<OtpResendState> {
  final authRepository = AuthRepository();
  OtpResendCubit(String email) : super(OtpResendInitial()) {
    resendOtp(email);
  }

  void resendOtp(String email) async {
    emit(OtpResendLoading());
    try {
      await authRepository.resend(email);
      emit(OtpResendSuccess(message: "Berhasil resend data"));
    } catch (e) {
      emit(OtpResendError(message: e.toString()));
    }
  }
}

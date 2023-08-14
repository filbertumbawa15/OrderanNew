import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/params/register_user_params.dart';
import 'package:tasorderan/repo/auth_repository.dart';

part 'otp_resend_state.dart';

class OtpResendCubit extends Cubit<OtpResendState> {
  final authRepository = AuthRepository();
  OtpResendCubit(String email) : super(OtpResendInitial());
}

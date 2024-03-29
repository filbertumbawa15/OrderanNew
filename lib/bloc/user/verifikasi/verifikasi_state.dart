part of 'verifikasi_cubit.dart';

@immutable
sealed class VerifikasiState {}

//DataVerifikasi
final class VerifikasiInitial extends VerifikasiState {}

final class VerifikasiLoading extends VerifikasiState {}

final class VerifikasiSuccess extends VerifikasiState {}

final class VerifikasiFailed extends VerifikasiState {
  final String? message;
  VerifikasiFailed(this.message);
}

//CekVerifikasi
final class VerifikasiCekLoading extends VerifikasiState {}

final class VerifikasiCekSuccess extends VerifikasiState {
  final String? message;
  final String? title;
  final String? path;
  final Widget? action;

  VerifikasiCekSuccess({this.message, this.title, this.path, this.action});
}

final class VerifikasiCekFailed extends VerifikasiState {}

//Ktp
final class VerifikasiKtpSuccess extends VerifikasiState {
  // final File? file;
  final Map<String, dynamic> param;
  VerifikasiKtpSuccess(this.param);
}

final class VerifikasiKtpFailed extends VerifikasiState {}

//Npwp
final class VerifikasiNpwpSuccess extends VerifikasiState {
  final File? file;
  VerifikasiNpwpSuccess(this.file);
}

final class VerifikasiNpwpFailed extends VerifikasiState {}

//Navigator(Edit Verifikasi)
final class EditVerifikasiLoading extends VerifikasiState {}

final class EditVerifikasiSuccess extends VerifikasiState {
  final Object? result;
  EditVerifikasiSuccess(this.result);
}

final class EditVerifikasiFailed extends VerifikasiState {}

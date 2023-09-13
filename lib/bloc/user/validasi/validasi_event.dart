part of 'validasi_bloc.dart';

@immutable
sealed class ValidasiEvent {}

class PesananValidasiEvent extends ValidasiEvent {}

class HistoryValidasiEvent extends ValidasiEvent {}

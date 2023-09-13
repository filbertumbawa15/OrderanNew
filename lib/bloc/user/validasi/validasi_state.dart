part of 'validasi_bloc.dart';

@immutable
sealed class ValidasiState {}

final class ValidasiInitial extends ValidasiState {}

final class ValidasiLoading extends ValidasiState {}

final class ValidasiSuccess extends ValidasiState {}

final class ValidasiFailed extends ValidasiState {
  final String? message;
  final String? content;
  final String? image;

  ValidasiFailed(this.message, this.content, this.image);
}

final class HistoryLoading extends ValidasiState {}

final class HistorySuccecss extends ValidasiState {}

final class HistoryFailed extends ValidasiState {
  final String? message;
  final String? content;
  final String? image;

  HistoryFailed(this.message, this.content, this.image);
}

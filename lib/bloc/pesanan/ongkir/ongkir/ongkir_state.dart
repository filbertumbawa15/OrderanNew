part of 'ongkir_bloc.dart';

@immutable
sealed class OngkirState {}

final class OngkirInitial extends OngkirState {}

final class OngkirLoading extends OngkirState {}

final class OngkirSuccess extends OngkirState {
  final Map<String, dynamic> result;
  OngkirSuccess({required this.result});
}

final class OngkirFailed extends OngkirState {
  final String message;
  OngkirFailed({required this.message});
}

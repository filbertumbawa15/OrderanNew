part of 'listpesananstatus_bloc.dart';

sealed class ListpesananstatusState extends Equatable {
  const ListpesananstatusState();

  @override
  List<Object> get props => [];
}

final class ListpesananstatusInitial extends ListpesananstatusState {}

final class ListpesananstatusLoading extends ListpesananstatusState {}

final class ListpesananstatusSuccess extends ListpesananstatusState {
  final ListPesananStatusResponse? response;
  const ListpesananstatusSuccess(this.response);
}

final class ListpesananstatusFailed extends ListpesananstatusState {
  final String? message;
  const ListpesananstatusFailed(this.message);
}

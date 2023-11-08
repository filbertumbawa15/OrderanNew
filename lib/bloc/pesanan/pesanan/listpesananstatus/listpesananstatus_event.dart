part of 'listpesananstatus_bloc.dart';

sealed class ListpesananstatusEvent extends Equatable {
  const ListpesananstatusEvent();

  @override
  List<Object> get props => [];
}

@immutable
class LoadListPesananStatus extends ListpesananstatusEvent {
  String? nobukti;
  int? qty;

  LoadListPesananStatus(this.nobukti, this.qty);
}

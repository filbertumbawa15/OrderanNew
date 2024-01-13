part of 'listqty_bloc.dart';

sealed class ListqtyEvent extends Equatable {
  const ListqtyEvent();

  @override
  List<Object> get props => [];
}

class ListQtyOrderEvent extends ListqtyEvent {
  String? nobukti;

  ListQtyOrderEvent({this.nobukti});
}

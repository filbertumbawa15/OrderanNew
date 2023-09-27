part of 'list_order_bloc.dart';

@immutable
sealed class ListOrderEvent {}

class ListPesananOrderEvent extends ListOrderEvent {
  int? userId;
  int? kondisi;
  int? utcTime;

  ListPesananOrderEvent(this.userId, this.kondisi, this.utcTime);
}

class ListPesananOrderNavigatorEvent extends ListOrderEvent {
  String route;
  String? nobukti;
  Object? param;

  ListPesananOrderNavigatorEvent(
      {required this.route, this.nobukti, this.param});
}

part of 'listorderdetail_cubit.dart';

@immutable
sealed class ListorderdetailState {}

final class ListorderdetailInitial extends ListorderdetailState {}

final class ListorderdetailSuccess extends ListorderdetailState {
  final String? param;
  final String? result;

  ListorderdetailSuccess({this.param, this.result});
}

final class ListorderdetailFailed extends ListorderdetailState {
  final String? param;
  final String? message;

  ListorderdetailFailed({this.param, this.message});
}

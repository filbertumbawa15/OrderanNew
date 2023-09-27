part of 'list_order_bloc.dart';

@immutable
sealed class ListOrderState {}

final class ListOrderInitial extends ListOrderState {}

final class ListOrderLoading extends ListOrderState {}

final class ListOrderSuccess extends ListOrderState {
  final List<ListOrderModels> result;
  ListOrderSuccess(this.result);
}

final class ListOrderFailed extends ListOrderState {
  final String message;
  ListOrderFailed(this.message);
}

//SuccessPayment
final class ListordernavigatorSuccessPaymentLoaded extends ListOrderState {}

final class ListordernavigatorSuccessPaymentFailed extends ListOrderState {}

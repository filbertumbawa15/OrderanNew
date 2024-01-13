part of 'listqty_bloc.dart';

sealed class ListqtyState extends Equatable {
  const ListqtyState();

  @override
  List<Object> get props => [];
}

final class ListqtyInitial extends ListqtyState {}

final class ListQtyLoading extends ListqtyState {}

final class ListQtySuccess extends ListqtyState {
  final List<ListQtyModels> result;
  const ListQtySuccess(this.result);
}

final class ListQtyFailed extends ListqtyState {
  final String message;
  const ListQtyFailed(this.message);
}

part of 'bayar_cubit.dart';

@immutable
abstract class BayarState extends Equatable {
  final Duration? elapsed;
  const BayarState(this.elapsed);
  @override
  List<Object?> get props => [elapsed];
}

final class BayarInitial extends BayarState {
  const BayarInitial() : super(const Duration(seconds: 0));

  @override
  List<Object?> get props => [];
}

final class BayarInProgress extends BayarState {
  const BayarInProgress({required Duration elapsed}) : super(elapsed);
}

final class BayarLoading extends BayarState {
  const BayarLoading() : super(const Duration(seconds: 0));
}

class BayarFailed extends BayarState {
  final String message;
  const BayarFailed(this.message) : super(const Duration(seconds: 0));
}

class BayarComplete extends BayarState {
  final Map<String, dynamic> result;
  const BayarComplete(this.result) : super(const Duration(seconds: 0));
}

class ProceedOrderLoading extends BayarState {
  const ProceedOrderLoading() : super(const Duration(seconds: 0));
}

class ProceedOrderSuccess extends BayarState {
  final ListOrderBayar listorderBayar;
  const ProceedOrderSuccess(this.listorderBayar)
      : super(const Duration(seconds: 0));
}

class ProceedOrderFailed extends BayarState {
  final String message;
  const ProceedOrderFailed(this.message) : super(const Duration(seconds: 0));
}

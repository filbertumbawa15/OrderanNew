import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bayar_state.dart';

class BayarCubit extends Cubit<BayarState> {
  BayarCubit() : super(BayarInitial());
}

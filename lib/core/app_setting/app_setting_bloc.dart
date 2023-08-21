import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  AppSettingBloc() : super(AppSettingInitial()) {
    on<AppSettingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

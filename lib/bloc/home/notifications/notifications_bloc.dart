import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasorderan/models/home_models.dart';
import 'package:tasorderan/repo/auth_repository.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final authRepository = AuthRepository();
  NotificationsBloc() : super(NotificationsInitial()) {
    on<NotificationsLoad>((event, emit) async {
      try {
        emit(NotificationsLoading());
        final response = await authRepository.listNotification();
        emit(NotificationsLoaded(response.listNotification));
      } catch (e) {
        emit(NotificationsFailed(e.toString()));
      }
    });
  }
}

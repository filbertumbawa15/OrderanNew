part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsLoaded extends NotificationsState {
  final List<NotificationsModels> result;
  const NotificationsLoaded(this.result);
}

final class NotificationsFailed extends NotificationsState {
  final String message;
  const NotificationsFailed(this.message);
}

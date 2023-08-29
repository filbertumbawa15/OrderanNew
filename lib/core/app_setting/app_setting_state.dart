part of 'app_setting_bloc.dart';

@immutable
sealed class AppSettingState {}

final class AppSettingInitial extends AppSettingState {}

final class AppSettingLoading extends AppSettingState {}

final class AppSettingAuthenticated extends AppSettingState {}

final class AppSettingUnAuthenticated extends AppSettingState {}

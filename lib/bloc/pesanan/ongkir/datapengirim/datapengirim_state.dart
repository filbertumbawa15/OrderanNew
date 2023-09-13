part of 'datapengirim_cubit.dart';

@immutable
sealed class DatapengirimState {}

final class DatapengirimInitial extends DatapengirimState {}

//Navigator(Asal)
final class AsalLoading extends DatapengirimState {}

final class AsalSuccess extends DatapengirimState {
  final Object? result;
  AsalSuccess(this.result);
}

final class AsalFailed extends DatapengirimState {}

//Navigator(Tujuan)
final class TujuanLoading extends DatapengirimState {}

final class TujuanSuccess extends DatapengirimState {
  final Object? result;
  TujuanSuccess(this.result);
}

final class TujuanFailed extends DatapengirimState {}

//Maps
final class MapLoading extends DatapengirimState {}

final class MapSuccess extends DatapengirimState {
  final PickResult result;
  final Map<String, dynamic> response;
  final Map<String, dynamic> direction;
  MapSuccess(this.result, this.response, this.direction);
}

final class MapFailed extends DatapengirimState {
  final String content;
  final String title;
  final String image;
  MapFailed(this.content, this.title, this.image);
}

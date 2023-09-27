part of 'dataorder_cubit.dart';

@immutable
sealed class DataorderState {}

final class DataorderInitial extends DataorderState {}

//Asal
final class DataorderAsalLoading extends DataorderState {}

final class DataorderAsalSuccess extends DataorderState {
  final Object? result;
  DataorderAsalSuccess(this.result);
}

final class DataorderAsalFailed extends DataorderState {}

//Tujuan
final class DataorderTujuanLoading extends DataorderState {}

final class DataorderTujuanSuccess extends DataorderState {
  final Object? result;
  DataorderTujuanSuccess(this.result);
}

final class DataorderTujuanFailed extends DataorderState {}

//Favorite(List)
final class DataorderFavoriteLoading extends DataorderState {}

final class DataorderFavoriteSuccess extends DataorderState {
  final Object? result;
  DataorderFavoriteSuccess(this.result);
}

final class DataorderFavoriteFailed extends DataorderState {}

//Favorite(Add)
final class DataorderFavoriteAddLoading extends DataorderState {}

final class DataorderFavoriteAddSuccess extends DataorderState {}

final class DataorderFavoriteAddFailed extends DataorderState {
  final String? error;
  DataorderFavoriteAddFailed(this.error);
}

//Maps
final class MapOrderLoading extends DataorderState {}

final class MapOrderSuccess extends DataorderState {
  final PickResult result;
  final Map<String, dynamic> response;
  final Map<String, dynamic> direction;
  MapOrderSuccess(this.result, this.response, this.direction);
}

final class MapOrderFailed extends DataorderState {
  final String content;
  final String title;
  final String image;
  MapOrderFailed(this.content, this.title, this.image);
}

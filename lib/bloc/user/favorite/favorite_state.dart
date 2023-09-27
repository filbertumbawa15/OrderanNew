part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final List<Favorites> listFavorites;
  FavoriteSuccess(this.listFavorites);
}

final class FavoriteFailed extends FavoriteState {
  final String message;
  FavoriteFailed(this.message);
}

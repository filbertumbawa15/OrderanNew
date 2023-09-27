import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasorderan/models/pesanan_models.dart';
import 'package:tasorderan/repo/home_repository.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final homeRepository = HomeRepository();
  FavoriteCubit() : super(FavoriteInitial()) {
    listFavorite();
  }

  void listFavorite() async {
    emit(FavoriteLoading());
    try {
      final response = await homeRepository.listFavorites();
      emit(FavoriteSuccess(response.listFavorites));
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
    }
  }
}

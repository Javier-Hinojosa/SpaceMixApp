import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeInitial());

  Future<void> loadDiscoverData() async {
    emit(HomeLoading());
    try {
      final tracks = await _homeRepository.getDiscoverTracks();
      emit(HomeLoaded(tracks: tracks));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}

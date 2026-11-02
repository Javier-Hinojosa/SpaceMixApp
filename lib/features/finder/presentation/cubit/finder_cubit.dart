import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/finder_repository.dart';
import 'finder_state.dart';

class FinderCubit extends Cubit<FinderState> {
  final FinderRepository repository;

  FinderCubit({required this.repository}) : super(FinderInitial());

  Future<void> loadFinderData() async {
    emit(FinderLoading());
    try {
      final trending = await repository.getTrendingTracks();
      emit(FinderLoaded(trendingTracks: trending));
    } catch (e) {
      emit(FinderError(message: 'Signal Lost: Unable to connect to mapping matrices.'));
    }
  }
}

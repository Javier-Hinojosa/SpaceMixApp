import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/library_repository.dart';
import 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryRepository repository;

  LibraryCubit({required this.repository}) : super(LibraryLoading());

  Future<void> loadLibraryData() async {
    emit(LibraryLoading());
    try {
      final tracks = await repository.getSavedTracks();
      if (tracks.isEmpty) {
        emit(LibraryEmpty());
      } else {
        emit(LibraryLoaded(savedTracks: tracks));
      }
    } catch (e) {
      emit(LibraryError(message: 'Failed to access database: ${e.toString()}'));
    }
  }

  Future<void> removeSavedItem(int trackId) async {
    try {
      await repository.removeTrack(trackId);
      loadLibraryData(); // refresh
    } catch (e) {
      // Ignored for now
    }
  }
}

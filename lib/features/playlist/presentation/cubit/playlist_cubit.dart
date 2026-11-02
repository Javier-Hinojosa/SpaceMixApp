import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/playlist_repository.dart';
import 'playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  final PlaylistRepository repository;

  PlaylistCubit({required this.repository}) : super(PlaylistInitial());

  Future<void> fetchPlaylistDetails(int playlistId) async {
    emit(PlaylistLoading());
    try {
      final playlist = await repository.getPlaylistDetails(playlistId);
      emit(PlaylistLoaded(playlist: playlist));
    } catch (e) {
      emit(PlaylistError(message: e.toString()));
    }
  }
}

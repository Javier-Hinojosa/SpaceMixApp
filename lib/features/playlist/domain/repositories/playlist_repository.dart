import 'package:spacemix/core/models/playlist_model.dart';

abstract class PlaylistRepository {
  Future<PlaylistModel> getPlaylistDetails(int id);
}

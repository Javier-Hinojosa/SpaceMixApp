import '../../../../core/models/track_model.dart';

abstract class LibraryRepository {
  Future<List<TrackModel>> getSavedTracks();
  Future<void> removeTrack(int trackId);
  Future<void> saveTrack(TrackModel track);
}

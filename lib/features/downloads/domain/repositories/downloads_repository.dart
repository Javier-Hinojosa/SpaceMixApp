import '../../../../core/models/track_model.dart';

abstract class DownloadsRepository {
  Future<List<TrackModel>> getDownloadedTracks();
}

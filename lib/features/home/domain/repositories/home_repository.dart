import '../../../../core/models/track_model.dart';

abstract class HomeRepository {
  Future<List<TrackModel>> getDiscoverTracks();
}

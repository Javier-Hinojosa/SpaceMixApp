import '../../../../core/models/track_model.dart';

abstract class FinderRepository {
  Future<List<TrackModel>> getTrendingTracks();
}

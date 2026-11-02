import '../../../../core/models/user_model.dart';
import '../../../../core/models/track_model.dart';

abstract class ProfileRepository {
  Future<UserModel> getUserProfile();
  Future<List<TrackModel>> getArtistTopTracks();
}

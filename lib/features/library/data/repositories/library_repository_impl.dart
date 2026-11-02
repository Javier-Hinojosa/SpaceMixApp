import '../../../../core/database/database_helper.dart';
import '../../../../core/models/track_model.dart';
import '../../domain/repositories/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final DatabaseHelper databaseHelper;

  LibraryRepositoryImpl({required this.databaseHelper});

  @override
  Future<List<TrackModel>> getSavedTracks() async {
    final List<Map<String, dynamic>> maps = await databaseHelper
        .queryAllFavorites();

    return List.generate(maps.length, (i) {
      return TrackModel(
        id: maps[i]['id'], // SQFlite integer to string mapping based on dummy id standard
        title: maps[i]['title'],
        artist: maps[i]['artist'],
        duration: maps[i]['duration'],
        description: maps[i]['description'] ?? '',
        imageurl: maps[i]['imageurl'] ?? '',
        artistid: int.parse(maps[i]['artistid']),
        url: maps[i]['url'] ?? '',
        gnre: maps[i]['gnre'] ?? '',
        gnreid: int.parse(maps[i]['gnreid']),
      );
    });
  }

  @override
  Future<void> removeTrack(int trackId) async {
    await databaseHelper.deleteFavorite(trackId);
  }

  @override
  Future<void> saveTrack(TrackModel track) async {
    await databaseHelper.insertFavorite({
      'id': track.id,
      'title': track.title,
      'duration': track.duration,
      'description': track.description,
      'imageurl': track.imageurl,
      'artistid': track.artistid,
      'artist': track.artist,
      'gnreid': track.gnreid,
      'gnre': track.gnre,
      'url': track.url,
    });
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'track_model.dart';

part 'playlist_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistModel {
  final int id;
  final String title;
  final String description;
  final String coverUrl;
  final String rating;
  final String creator;
  final List<TrackModel> tracks;

  PlaylistModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.rating,
    required this.creator,
    required this.tracks,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => _$PlaylistModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistModelToJson(this);
}

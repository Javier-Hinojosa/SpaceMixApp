import 'package:json_annotation/json_annotation.dart';

part 'track_model.g.dart';

@JsonSerializable()
class TrackModel {
  final int id;
  final String title;
  final String duration;
  final String description;
  final String imageurl;
  final String url;
  final int artistid;
  final String artist;
  final int gnreid;
  final String gnre;

  TrackModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
    required this.imageurl,
    required this.url,
    required this.artistid,
    required this.artist,
    required this.gnreid,
    required this.gnre,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) => _$TrackModelFromJson(json);
  Map<String, dynamic> toJson() => _$TrackModelToJson(this);
}

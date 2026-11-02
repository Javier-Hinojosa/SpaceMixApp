import 'package:json_annotation/json_annotation.dart';

part 'search_result_model.g.dart';

@JsonSerializable()
class SearchResultModel {
  @JsonKey(name: 'song_id')
  final int songId;
  @JsonKey(name: 'song_name')
  final String songName;
  @JsonKey(name: 'song_image')
  final String songImage;
  @JsonKey(name: 'artist_name')
  final String artistName;
  @JsonKey(name: 'artist_image')
  final String artistImage;
  @JsonKey(name: 'genre_name')
  final String genreName;
  final int score;
  final String url;

  SearchResultModel({
    required this.songId,
    required this.songName,
    required this.songImage,
    required this.artistName,
    required this.artistImage,
    required this.genreName,
    required this.score,
    required this.url,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => _$SearchResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultModelToJson(this);
}

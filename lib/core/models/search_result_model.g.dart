// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) =>
    SearchResultModel(
      songId: (json['song_id'] as num).toInt(),
      songName: json['song_name'] as String,
      songImage: json['song_image'] as String,
      artistName: json['artist_name'] as String,
      artistImage: json['artist_image'] as String,
      genreName: json['genre_name'] as String,
      score: (json['score'] as num).toInt(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
    <String, dynamic>{
      'song_id': instance.songId,
      'song_name': instance.songName,
      'song_image': instance.songImage,
      'artist_name': instance.artistName,
      'artist_image': instance.artistImage,
      'genre_name': instance.genreName,
      'score': instance.score,
      'url': instance.url,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  duration: json['duration'] as String,
  description: json['description'] as String,
  imageurl: json['imageurl'] as String,
  url: json['url'] as String,
  artistid: (json['artistid'] as num).toInt(),
  artist: json['artist'] as String,
  gnreid: (json['gnreid'] as num).toInt(),
  gnre: json['gnre'] as String,
);

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'description': instance.description,
      'imageurl': instance.imageurl,
      'url': instance.url,
      'artistid': instance.artistid,
      'artist': instance.artist,
      'gnreid': instance.gnreid,
      'gnre': instance.gnre,
    };

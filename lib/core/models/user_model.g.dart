// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  profileImage: json['profileImage'] as String,
  bio: json['bio'] as String,
  followers: (json['followers'] as num).toInt(),
  following: (json['following'] as num).toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'profileImage': instance.profileImage,
  'bio': instance.bio,
  'followers': instance.followers,
  'following': instance.following,
};

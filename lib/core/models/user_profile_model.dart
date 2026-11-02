import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  final String id;
  final String username;
  final String email;
  final String profileImage;
  final String bio;
  final int followers;
  final int following;

  UserProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profileImage,
    required this.bio,
    required this.followers,
    required this.following,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}

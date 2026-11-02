import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:spacemix/core/models/track_model.dart';
import 'package:spacemix/core/models/user_model.dart';
import 'package:spacemix/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<UserModel> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    final String response = await rootBundle.loadString(
      'assets/data/user_profile.json',
    );
    final Map<String, dynamic> data = json.decode(response);
    return UserModel.fromJson(data);
  }

  @override
  Future<List<TrackModel>> getArtistTopTracks() async {
    await Future.delayed(const Duration(seconds: 1));
    // Since there's no native tracks array, we fake one from the general search set for now.
    try {
      final String response = await rootBundle.loadString(
        'assets/data/search_content.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((json) => TrackModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}

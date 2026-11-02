import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:spacemix/core/models/playlist_model.dart';
import 'package:spacemix/features/playlist/domain/repositories/playlist_repository.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  @override
  Future<PlaylistModel> getPlaylistDetails(int id) async {
    // Artificial mock delay
    await Future.delayed(const Duration(milliseconds: 1200));

    try {
      final String response = await rootBundle.loadString(
        'assets/data/playlist_detail.json',
      );
      final Map<String, dynamic> data = json.decode(response);
      return PlaylistModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to parse Playlist Data: $e');
    }
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:spacemix/core/models/track_model.dart';
import 'package:spacemix/features/downloads/domain/repositories/downloads_repository.dart';

class DownloadsRepositoryImpl implements DownloadsRepository {
  @override
  Future<List<TrackModel>> getDownloadedTracks() async {
    // Simulate disk reading time
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final String response = await rootBundle.loadString(
        'assets/data/main_content.json',
      );
      final Map<String, dynamic> data = json.decode(response);

      // Pluck a small subset mapping local downloads visually
      final List<dynamic> trendingData = data['trending'];
      final fullList = trendingData
          .map((json) => TrackModel.fromJson(json))
          .toList();

      return fullList.take(3).toList();
    } catch (e) {
      return [];
    }
  }
}

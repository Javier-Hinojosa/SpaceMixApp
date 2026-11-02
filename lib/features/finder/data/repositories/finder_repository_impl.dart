import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:spacemix/features/finder/domain/repositories/finder_repository.dart';
import '../../../../core/models/track_model.dart';

class FinderRepositoryImpl implements FinderRepository {
  @override
  Future<List<TrackModel>> getTrendingTracks() async {
    // Simulate 2 second network delay
    await Future.delayed(const Duration(seconds: 2));

    try {
      final String response = await rootBundle.loadString(
        'assets/data/search_content.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((json) => TrackModel.fromJson(json)).toList();
    } catch (e) {
      // Return empty safely on dummy failure
      return [];
    }
  }
}

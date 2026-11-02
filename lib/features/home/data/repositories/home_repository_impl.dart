import 'dart:convert';
import 'package:spacemix/core/app_envs.dart';
import 'package:spacemix/core/models/request_model.dart';
import 'package:spacemix/core/services/service_provider.dart';
import '../../../../core/models/track_model.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends BaseService implements HomeRepository  {
  @override
  Future<List<TrackModel>> getDiscoverTracks() async {

    try {

      RequestModel jsonResponse = await provider.request<dynamic>(
          RequestMethod.post,
          Uri.parse('${AppEnvs.apiURL}/rpc/get_all_song'));

      final List<dynamic> jsonList = json.decode(jsonResponse.result);
      return jsonList.map((json) => TrackModel.fromJson(json)).toList();

    } catch (e) {
      throw Exception('Failed to load discover tracks: $e');
    }
  }
}

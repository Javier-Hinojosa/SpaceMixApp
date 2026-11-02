import 'dart:convert';

import 'package:spacemix/core/app_envs.dart';
import 'package:spacemix/core/services/service_provider.dart';

class TrackStorageException implements Exception {
  final String message;
  TrackStorageException(this.message);

  @override
  String toString() => 'TrackStorageException: $message';
}

class TrackStorageService extends BaseService {
  /// Pide a la Edge Function `sign-track-url` una URL prefirmada de Backblaze B2
  /// para [fileName] (ej. `Techno3.mp3`). Úsala con `AudioPlayer.setUrl`.
  Future<String> getTrackUrl(String fileName, {int expiresInSeconds = 900}) async {
    final endpoint = Uri.parse('${AppEnvs.apiURL}/functions/v1/sign-track-url');

    final response = await provider.request(
      RequestMethod.post,
      endpoint,
      body: jsonEncode({'file': fileName, 'expires': expiresInSeconds}),
    );

    if (response.isError) {
      throw TrackStorageException(response.result);
    }

    final data = jsonDecode(response.result) as Map<String, dynamic>;
    final url = data['url'] as String?;
    if (url == null) {
      throw TrackStorageException('Respuesta sin URL');
    }
    return url;
  }
}

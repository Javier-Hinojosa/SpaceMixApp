import 'dart:async';
import 'dart:io';

import 'package:spacemix/core/app_envs.dart';
import 'package:spacemix/core/models/request_model.dart';
import 'package:http/http.dart' as http;

enum RequestMethod { get, post, put, patch, delete }

class BaseService {
  final provider = ServiceProvider.instance;
}

class ServiceProvider {

  ServiceProvider._privateConstructor();
  static final ServiceProvider _instance = ServiceProvider._privateConstructor();
  static ServiceProvider get instance => _instance;

  static final Map<String, String> headers = <String, String> {
    HttpHeaders.acceptHeader: '*/*',
    HttpHeaders.contentTypeHeader: 'application/json',
    "apikey": AppEnvs.supabaseKey,
    "Authorization": "Bearer ${AppEnvs.supabaseKey}"
  };

  Future<RequestModel> request<T>(RequestMethod method, Uri endPoint, {String body = '', bool returnFullResponse = false}) async {
    const int maxRetries = 3;
    int retryCount = 0;
    bool success = false;

    RequestModel responseModel = RequestModel(result: "");

    // Realiza la solicitud con retriabilidad
    while (!success && retryCount < maxRetries) {
      try {

        http.Response resp = await _request(method, endPoint, body: body, headers: headers).timeout(const Duration(seconds: 5));

        print('Request to $endPoint with method $method returned status code ${resp.statusCode}');

        responseModel = _validStatusCode(resp);
        if(responseModel.code=="201" || responseModel.code=="200"){
          success = true;
        }

      } on TimeoutException catch (_) {
        responseModel= RequestModel(result: "tiempo de espera agotado, intente nuevamente",code: "402");
      } on SocketException catch(r) {
        responseModel= RequestModel(result: r.message,code: r.port.toString());
      } on Error catch (e) {
        responseModel= RequestModel(result: e.toString(),code: "404");
      }

      print('Request to $endPoint with method $method returned status code ${responseModel.code}');

      // Incrementa el contador de intentos si no ha tenido éxito
      if (!success) {
        retryCount++;

        if (retryCount < maxRetries) {
          // Espera 1 segundo antes de intentar de nuevo
          await Future.delayed(const Duration(seconds: 1));
        }
      }
    }

    return responseModel;
  }

  Future<http.Response> _request(RequestMethod method, Uri url, {String body = '', Map<String, String>? headers}) =>
    switch(method) {
      RequestMethod.get => http.get(url, headers: headers),
      RequestMethod.post => http.post(url, body: body, headers: headers),
      RequestMethod.put => http.put(url, body: body, headers: headers),
      RequestMethod.patch => http.patch(url, body: body, headers: headers),
      RequestMethod.delete => http.delete(url, body: body, headers: headers)
  };


  RequestModel _validStatusCode(http.Response? response) {
    if (response != null) {
      switch (response.statusCode) {
        case 200:
        case 201:
          return RequestModel(result: response.body,code: response.statusCode.toString(),isError: false);
        case 400:
        case 401: //invalid auth
        case 403:
        case 307:
        case 500:
        case 502:
          return RequestModel(
              result: response.body.isEmpty?response.reasonPhrase??"exception": response.body,
              code: response.statusCode.toString()
          );
        default:
          return RequestModel(result: "Error al comunicar con el servidor" ,code: response.statusCode.toString());
      }
    } else {
      return RequestModel(result: "Error occured while Communication", code: "404");
    }
  }
}

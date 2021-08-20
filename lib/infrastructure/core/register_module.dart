import 'dart:io';

import 'package:boilerplate/domain/core/i_storage.dart';
import 'package:boilerplate/infrastructure/core/auth_interceptor.dart';
import 'package:boilerplate/infrastructure/core/logger_interceptor.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class RegisterModule {
  @Environment('prod')
  @Named('baseUrl')
  String get baseUrl => 'https://jsonplaceholder.typicode.com';

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  HiveInterface get hive => Hive;

  @lazySingleton
  Logger get logger => Logger();

  @preResolve
  @lazySingleton
  Future<Dio> dio(@Named('baseUrl') String baseUrl, IStorage _storage) async {
    Dio _dio = Dio();
    BaseOptions _options = BaseOptions(
      connectTimeout: 120000,
      receiveTimeout: 60000,
      sendTimeout: 60000,
      headers: null,
      baseUrl: baseUrl,
    );
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return baseUrl.contains(host);
      };
      return client;
    };

    await _storage.openBox(StorageConstants.security);
    _dio.interceptors.add(AuthInterceptor(_storage, 'sessionId'));
    _dio.interceptors.add(LoggerInterceptor(
        requestBody: true,
        request: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    // _storage.close();
    _dio.options = _options;
    return _dio;
  }
}

import 'package:code_id_flutter/code_id_flutter.dart';
import 'package:code_id_network/code_id_network.dart';
import 'package:code_id_storage/code_id_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @Named('baseUrl')
  String get baseUrl => 'https://jsonplaceholder.typicode.com';

  @preResolve
  @lazySingleton
  Future<INetworkService> network(
    @Named('baseUrl') String baseUrl,
  ) async {
    IStorage _storage = Storage;
    await _storage.openBox('authKey');

    NetworkService _service = NetworkService(baseUrl: baseUrl);

    _service.addInterceptors([
      AuthInterceptor(
        storage: _storage,
        authKey: 'sessionId',
        authHeadersBuilder: (token) {
          return {"token": token};
        },
      ),
      LoggerInterceptor(
          requestBody: true,
          request: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true),
    ]);

    return NetworkService(
      baseUrl: baseUrl,
    );
  }
}

class NetworkException implements Exception {
  late dynamic message;

  NetworkException(dynamic message) {
    this.message = message;
  }
}

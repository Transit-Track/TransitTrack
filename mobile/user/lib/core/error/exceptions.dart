class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class UnexpectedException implements Exception {
   final String message;

  UnexpectedException({required this.message});
}

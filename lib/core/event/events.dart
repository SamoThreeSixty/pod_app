class Failure {
  final String message;
  Failure([this.message = 'An unexpected error has occurred!']);
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

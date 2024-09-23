class Failure {
  final String message;
  Failure([this.message = 'An unexpected error has occurred!']);
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class SupabaseException implements Exception {
  final String message;
  final String code;
  final int statusCode;

  const SupabaseException(
    this.message,
    this.code,
    this.statusCode,
  );
}

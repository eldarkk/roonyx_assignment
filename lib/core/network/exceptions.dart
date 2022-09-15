class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class UserNotLoggedInException implements Exception {
  final String message;
  UserNotLoggedInException(this.message);
}

class UnAuthorizedException implements Exception {
  final String message;
  UnAuthorizedException(this.message);
}

class UserForbiddenException implements Exception {
  final String message;
  UserForbiddenException(this.message);
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(this.message);
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class UnprocessedException implements Exception {
  final String message;
  UnprocessedException(this.message);
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException(this.message);
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}

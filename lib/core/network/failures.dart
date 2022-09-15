import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});
  @override
  List<Object> get props => [message];
}

// General Failures

class UserNotLoggedInFailure extends Failure {
  const UserNotLoggedInFailure(String message) : super(message: message);
}

class ApiFailure extends Failure {
  const ApiFailure(String message) : super(message: message);
}

class InternetFailure extends Failure {
  const InternetFailure(String message) : super(message: message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message: message);
}

Failure handleAndThrowFailure(Exception exception) {
  if (exception is UserNotLoggedInException) {
    return UserNotLoggedInFailure(exception.message);
  } else if (exception is ApiException) {
    return ApiFailure(exception.message);
  } else if (exception is NoInternetException) {
    return InternetFailure(exception.message);
  } else {
    return const UnknownFailure('Unknown failure');
  }
}

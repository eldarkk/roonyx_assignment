import 'package:dartz/dartz.dart';
import 'package:test_assignment/core/network/failures.dart';
import 'package:test_assignment/models/account.dart';

import '../core/base/usecase.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<Account, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, Account>> call(LoginParams params) async {
    return await repository.loginUser(
        login: params.login, password: params.password);
  }
}

class LoginParams {
  final String login;
  final String password;

  LoginParams({
    required this.login,
    required this.password,
  });
}

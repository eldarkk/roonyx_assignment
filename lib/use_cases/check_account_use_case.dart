import 'package:dartz/dartz.dart';
import 'package:test_assignment/core/network/failures.dart';
import 'package:test_assignment/models/account.dart';

import '../core/base/usecase.dart';
import '../repository/auth_repository.dart';

class CheckAccountUseCase implements UseCase<Account, NoParams> {
  final AuthRepository repository;

  CheckAccountUseCase({required this.repository});

  @override
  Future<Either<Failure, Account>> call(NoParams params) async {
    return await repository.checkAccount();
  }
}

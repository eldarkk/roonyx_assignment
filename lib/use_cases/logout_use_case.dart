import 'package:dartz/dartz.dart';
import 'package:test_assignment/core/network/failures.dart';
import 'package:test_assignment/models/generic.dart';

import '../core/base/usecase.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase implements UseCase<Generic, NoParams> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, Generic>> call(NoParams empty) async {
    return await repository.logoutUser();
  }
}

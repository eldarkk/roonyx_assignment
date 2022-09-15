import 'package:dartz/dartz.dart';
import 'package:test_assignment/datasource/auth_local_data_source.dart';
import 'package:test_assignment/models/account.dart';
import 'package:test_assignment/models/generic.dart';

import '../core/network/failures.dart';
import '../datasource/auth_remote_data_source.dart';

abstract class AuthRepository {
  Future<Either<Failure, Account>> loginUser(
      {required String login, required String password});

  Future<Either<Failure, Generic>> logoutUser();

  Future<Either<Failure, Account>> checkAccount();
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, Account>> loginUser(
      {required String login, required String password}) async {
    try {
      final response =
          await remoteDataSource.loginUser(login: login, password: password);
      await localDataSource.saveAccount(account: response);
      return Right(response);
    } catch (exception) {
      final failure = handleAndThrowFailure(exception as Exception);
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Generic>> logoutUser() async {
    try {
      final response = await remoteDataSource.logoutUser();
      if (response.success) {
        await localDataSource.removeAccount();
      }
      return Right(response);
    } catch (exception) {
      final failure = handleAndThrowFailure(exception as Exception);
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Account>> checkAccount() async {
    try {
      final response = await localDataSource.getAccount();
      return Right(response);
    } catch (exception) {
      return const Left(UserNotLoggedInFailure('not logged in'));
    }
  }
}

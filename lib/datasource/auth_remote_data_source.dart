import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_assignment/models/generic.dart';

import '../core/network/api_client.dart';
import '../core/network/failures.dart';
import '../models/account.dart';

abstract class AuthRemoteDataSource {
  Future<Account> loginUser({required String login, required String password});
  Future<Generic> logoutUser();
}

class AuthRemotedataSourceImpl implements AuthRemoteDataSource {
  final ApiService client;
  AuthRemotedataSourceImpl({required this.client});

  @override
  Future<Account> loginUser(
      {required String login, required String password}) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const InternetFailure('no connection');
    }
    final params = {'login': login, 'password': password};
    final response = await client.post('/login', params);
    return Account.fromMap(response['data']);
  }

  @override
  Future<Generic> logoutUser() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const InternetFailure('no connection');
    }
    final response = await client.get('/logout');
    return Generic.fromMap(response);
  }
}

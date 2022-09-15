import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/exceptions.dart';
import '../models/account.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAccount({required Account account});
  Future<Account> getAccount();
  Future<bool> removeAccount();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl({required this.prefs});

  @override
  Future<void> saveAccount({required Account account}) {
    final jsonString = json.encode(account.toMap());
    return prefs.setString('account', jsonString);
  }

  @override
  Future<Account> getAccount() {
    final jsonString = prefs.getString('account');
    if (jsonString != null) {
      final data = json.decode(jsonString);
      return Future.value(Account.fromMap(data));
    } else {
      throw UserNotLoggedInException('not logged in');
    }
  }

  @override
  Future<bool> removeAccount() async {
    return await prefs.remove('account');
  }
}

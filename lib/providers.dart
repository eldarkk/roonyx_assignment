import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/repository_provider.dart';
import 'package:test_assignment/repository/auth_repository.dart';

import 'injection_container.dart';
import 'use_cases/check_account_use_case.dart';
import 'use_cases/login_use_case.dart';
import 'use_cases/logout_use_case.dart';

class Providers {
  static List<RepositoryProviderSingleChildWidget> generateUseCases() {
    return [
      RepositoryProvider(
          create: (_) => CheckAccountUseCase(repository: sl<AuthRepository>())),
      RepositoryProvider(
          create: (_) => LoginUseCase(repository: sl<AuthRepository>())),
      RepositoryProvider(
          create: (_) => LogoutUseCase(repository: sl<AuthRepository>())),
    ];
  }
}

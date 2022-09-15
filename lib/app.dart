import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'launcher.dart';
import 'presentation/cubit/auth_cubit.dart';
import 'presentation/cubit/login_cubit.dart';
import 'presentation/screen/logged_in_screen.dart';
import 'presentation/screen/login_screen.dart';
import 'providers.dart';
import 'use_cases/check_account_use_case.dart';
import 'use_cases/login_use_case.dart';
import 'use_cases/logout_use_case.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: Providers.generateUseCases(),
      child: BlocProvider(
        create: (context) => AuthCubit(
            useCase: RepositoryProvider.of<CheckAccountUseCase>(context)),
        child: BlocProvider(
          create: (context) => LoginCubit(
            loginUseCase: RepositoryProvider.of<LoginUseCase>(context),
            logoutUseCase: RepositoryProvider.of<LogoutUseCase>(context),
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial) {
                  return const LoadingScreen();
                } else if (state is LoggedIn) {
                  return const LoggedInScreen();
                } else {
                  return const LoginScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

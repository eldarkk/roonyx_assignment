import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_assignment/presentation/cubit/auth_cubit.dart';
import 'package:test_assignment/presentation/cubit/login_cubit.dart';

class LoggedInScreen extends StatelessWidget {
  static const routeName = 'loggedin_screen';
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Welcome',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 20)),
            actions: [
              TextButton(
                  onPressed: () {
                    final cubit = context.read<LoginCubit>();
                    cubit.logout();
                  },
                  child: Text('Logout',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white)))
            ],
          ),
          body: Center(
              child: Text('You are logged in !',
                  style: Theme.of(context).textTheme.bodyText1)),
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              final cubit = context.read<AuthCubit>();
              cubit.loggedOut();
            }
          },
          child: const SizedBox(),
        )
      ],
    );
  }
}

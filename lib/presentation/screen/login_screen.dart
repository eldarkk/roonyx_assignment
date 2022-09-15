import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:test_assignment/presentation/cubit/auth_cubit.dart';

import '../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              title: Text('Login',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white, fontSize: 20))),
          body: KeyboardDismissOnTap(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        controller: _loginController,
                        minLines: 1,
                        maxLines: 1,
                        maxLength: 24,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter login';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(30, 20, 30, 20),
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 4, color: Colors.blue),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            hintText: 'Login',
                            counterText: "",
                            counterStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.2),
                                fontSize: 20),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 18)),
                      )),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      minLines: 1,
                      maxLines: 1,
                      maxLength: 24,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(30, 20, 30, 20),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Colors.blue),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          hintText: 'password',
                          counterText: "",
                          counterStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.2),
                              fontSize: 20),
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final cubit = context.read<LoginCubit>();
                          cubit.login(
                              login: _loginController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: Text('Login',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.blue, fontSize: 18)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              final cubit = context.read<AuthCubit>();
              cubit.loggedIn();
            }
          },
          child: Text('', style: Theme.of(context).textTheme.bodyText1),
        )
      ],
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

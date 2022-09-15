part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Account account;
  const LoginSuccess(this.account);
}

class LogoutSuccess extends LoginState {
  final Generic success;
  const LogoutSuccess(this.success);
}

class LoginFailure extends LoginState {
  final String? message;

  const LoginFailure({this.message});
}

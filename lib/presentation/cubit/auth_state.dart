part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoggedIn extends AuthState {}

class NotLoggedIn extends AuthState {}

class AuthLoading extends AuthState {}

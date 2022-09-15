import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_assignment/core/base/usecase.dart';

import '../../core/network/failures.dart';
import '../../models/account.dart';
import '../../models/generic.dart';
import '../../use_cases/login_use_case.dart';
import '../../use_cases/logout_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  LoginCubit({required this.loginUseCase, required this.logoutUseCase})
      : super(LoginInitial());

  Future<void> login({required String login, required String password}) async {
    emit(LoginLoading());
    final response =
        await loginUseCase.call(LoginParams(login: login, password: password));
    response.fold((error) {
      if (error is InternetFailure) {
        emit(LoginFailure(message: error.message));
      } else if (error is UserNotLoggedInFailure) {
        emit(LoginFailure(message: error.message));
      } else if (error is ApiFailure) {
        emit(LoginFailure(message: error.message));
      } else {
        emit(LoginFailure(message: error.message));
      }
    }, (success) {
      emit(LoginSuccess(success));
    });
  }

  Future<void> logout() async {
    emit(LoginLoading());
    final response = await logoutUseCase.call(NoParams());
    response.fold((error) {
      if (error is InternetFailure) {
        emit(LoginFailure(message: error.message));
      } else if (error is UserNotLoggedInFailure) {
        emit(LoginFailure(message: error.message));
      } else if (error is ApiFailure) {
        emit(LoginFailure(message: error.message));
      } else {
        emit(LoginFailure(message: error.message));
      }
    }, (success) {
      emit(LogoutSuccess(success));
    });
  }
}

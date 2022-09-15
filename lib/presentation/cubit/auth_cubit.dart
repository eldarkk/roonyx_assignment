import 'package:bloc/bloc.dart';
import 'package:test_assignment/core/base/usecase.dart';
import 'package:test_assignment/use_cases/check_account_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CheckAccountUseCase useCase;

  AuthCubit({required this.useCase}) : super(AuthInitial());

  Future<void> isLoggedIn() async {
    final response = await useCase.call(NoParams());
    response.fold((error) {
      emit(NotLoggedIn());
    }, (success) {
      emit(LoggedIn());
    });
  }

  Future<void> loggedIn() async {
    emit(LoggedIn());
  }

  Future<void> loggedOut() async {
    emit(NotLoggedIn());
  }
}

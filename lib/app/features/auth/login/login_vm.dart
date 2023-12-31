import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/app/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/app/core/fp/either.dart';
import 'package:dw_barbershop/app/core/fp/nil.dart';
import 'package:dw_barbershop/app/core/providers/application_providers.dart';
import 'package:dw_barbershop/app/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Success<ServiceException, Nil>():
        // Buscar dados do usuário logado
        // Fazer uma análise para qual o tipo do login
        break;
      case Failure<ServiceException, Nil>(
          exception: ServiceException(:final message)
        ):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandler.close();
  }
}

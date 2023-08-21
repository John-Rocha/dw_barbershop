import 'package:dw_barbershop/app/core/constants/local_storage_keys.dart';
import 'package:dw_barbershop/app/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/app/core/exceptions/service_exception.dart';

import 'package:dw_barbershop/app/core/fp/either.dart';

import 'package:dw_barbershop/app/core/fp/nil.dart';
import 'package:dw_barbershop/app/repositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository _userRepository;
  UserLoginServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<ServiceException, Nil>> execute(
    String email,
    String password,
  ) async {
    final loginResult = await _userRepository.login(email, password);
    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);

      case Failure(:final exception):
        return switch (exception) {
          AuthError() =>
            Failure(ServiceException(message: 'Erro ao realizar o login')),
          AuthUnauthorizedException() =>
            Failure(ServiceException(message: 'Email ou senha inválidos '))
        };
    }
  }
}

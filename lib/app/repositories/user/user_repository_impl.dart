import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/app/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/app/core/exceptions/repository_exception.dart';

import 'package:dw_barbershop/app/core/fp/either.dart';
import 'package:dw_barbershop/app/core/rest_client/rest_client.dart';
import 'package:dw_barbershop/app/models/user_model.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;

  UserRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<AuthException, String>> login(
    String email,
    String password,
  ) async {
    try {
      final Response(:data) = await _restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Email ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar o login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar o login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await _restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Erro ao buscar usuário loagdo'),
      );
    } on ArgumentError catch (e, s) {
      log('Error invalid json', error: e, stackTrace: s);
      return Failure(e.message);
    }
  }
}

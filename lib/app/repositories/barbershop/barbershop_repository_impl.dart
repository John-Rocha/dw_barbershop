import 'package:dio/dio.dart';
import 'package:dw_barbershop/app/core/exceptions/repository_exception.dart';

import 'package:dw_barbershop/app/core/fp/either.dart';
import 'package:dw_barbershop/app/core/rest_client/rest_client.dart';

import 'package:dw_barbershop/app/models/barbershop_model.dart';

import 'package:dw_barbershop/app/models/user_model.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
    UserModel userModel,
  ) async {
    switch (userModel) {
      case UserModelAdm():
        final Response(:data) = await restClient.auth.get(
          'barbeshop',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(data: List(first: data)) = await restClient.auth.get(
          'barbeshop/${userModel.barbershopId}',
        );
        return Success(BarbershopModel.fromMap(data));
    }
  }
}

import 'package:dw_barbershop/app/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/app/core/fp/either.dart';
import 'package:dw_barbershop/app/models/barbershop_model.dart';
import 'package:dw_barbershop/app/models/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
    UserModel userModel,
  );
}

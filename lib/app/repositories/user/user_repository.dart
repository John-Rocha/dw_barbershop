import 'package:dw_barbershop/app/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/app/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/app/core/fp/either.dart';
import 'package:dw_barbershop/app/models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> me();
}

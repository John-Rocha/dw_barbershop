import 'package:dw_barbershop/app/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/app/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}

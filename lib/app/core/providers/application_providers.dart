import 'package:dw_barbershop/app/core/rest_client/rest_client.dart';
import 'package:dw_barbershop/app/repositories/user/user_repository.dart';
import 'package:dw_barbershop/app/repositories/user/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef rest) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

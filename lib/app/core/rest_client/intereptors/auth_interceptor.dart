import 'package:dio/dio.dart';
import 'package:dw_barbershop/app/core/constants/local_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final prefs = await SharedPreferences.getInstance();
      headers.addAll(
        {
          authHeaderKey:
              'Bearer : ${prefs.getString(LocalStorageKeys.accessToken)}'
        },
      );
    }
    handler.next(options);
  }
}

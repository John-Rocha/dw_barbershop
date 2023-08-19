import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/app/core/ui/widgets/barber_shop_loader.dart';
import 'package:dw_barbershop/app/features/auth/login/login_page.dart';
import 'package:dw_barbershop/app/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarberShopApp extends StatelessWidget {
  const BarberShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarberShopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'DW BarberShop',
          debugShowCheckedModeBanner: false,
          navigatorObservers: [asyncNavigatorObserver],
          initialRoute: '/',
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
          },
        );
      },
    );
  }
}

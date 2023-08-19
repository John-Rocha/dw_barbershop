import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/app/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarberShopApp extends StatelessWidget {
  const BarberShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'DW BarberShop',
          navigatorObservers: [asyncNavigatorObserver],
          initialRoute: '/',
          routes: {
            '/': (_) => const SplashPage(),
          },
        );
      },
    );
  }
}

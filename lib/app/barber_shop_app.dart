import 'package:dw_barbershop/app/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarberShopApp extends StatelessWidget {
  const BarberShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DW BarberShop',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}

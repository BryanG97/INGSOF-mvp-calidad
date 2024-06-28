import 'package:flutter/material.dart';

import 'package:mvp_calidad/config/router/app_router.dart';
import 'package:mvp_calidad/config/theme/app_theme.dart';

import 'package:mvp_calidad/presentation/providers/products/product_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    productProvider.read.getInitialProducts();
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}

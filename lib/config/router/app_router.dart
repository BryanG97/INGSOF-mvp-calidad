import 'package:go_router/go_router.dart';

import 'package:mvp_calidad/presentation/widgets/shared/custom_bottom_navigation_bar.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      name: CustomBottomNavigationBar.name,
      builder: (context, state) => const CustomBottomNavigationBar(),
    ),

  ]
);
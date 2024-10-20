import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/presentation/widgets/pages/detail_page.dart';
import 'package:images/presentation/widgets/pages/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainNavigation {
  GoRouter get router => _router;

  final _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: RouteNames.detail,
            path: RouteNames.detail,
            builder: (context, state) =>
                DetailPage(image: state.extra as ImageEntity),
          ),
        ],
      ),
    ],
  );

  Future<void> navigateToDetail(ImageEntity image) {
    return _router.pushNamed(RouteNames.detail, extra: image);
  }
}

class RouteNames {
  static const home = 'home';
  static const detail = 'detail';
}

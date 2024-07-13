import 'package:app/ui/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/local_database/db_position.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator = GlobalKey(debugLabel: 'shell');

class AppRouter {
  static GoRouter router() {
    return GoRouter(
      navigatorKey: _rootNavigator,
      initialLocation: SplashView.route,
      routes: [
        GoRoute(
          path: SplashView.route,
          name: SplashView.route,
          builder: (_, __) => const SplashView(),
        ),
        GoRoute(
          path: PermissionsView.route,
          name: PermissionsView.route,
          builder: (_, __) => const PermissionsView(),
        ),
        GoRoute(
          path: LocationView.route,
          name: LocationView.route,
          builder: (_, state) => LocationView(position: state.extra as DBPosition),
        ),
        GoRoute(
          path: LocationsView.route,
          name: LocationsView.route,
          builder: (_, __) => const LocationsView(),
        ),
      ],
    );
  }
}

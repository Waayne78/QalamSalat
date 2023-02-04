// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../views/home/home.dart' as _i3;
import '../views/main_view.dart' as _i2;
import '../views/settings/notifications_view.dart' as _i4;
import '../views/settings/settings_page.dart' as _i1;
import '../views/settings/state/qiblah_view.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SettingsRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SettingsView(),
      );
    },
    MainRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.MainView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomeView(),
      );
    },
    NotificationsRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.NotificationsView(),
      );
    },
    QiblahRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.QiblahView(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SettingsRoute.name,
          path: '/settings-view',
        ),
        _i6.RouteConfig(
          MainRoute.name,
          path: '/',
          children: [
            _i6.RouteConfig(
              HomeRoute.name,
              path: 'home-view',
              parent: MainRoute.name,
            ),
            _i6.RouteConfig(
              NotificationsRoute.name,
              path: 'notifications-view',
              parent: MainRoute.name,
            ),
            _i6.RouteConfig(
              QiblahRoute.name,
              path: 'qiblah-view',
              parent: MainRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SettingsView]
class SettingsRoute extends _i6.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: '/settings-view',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i2.MainView]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-view',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.NotificationsView]
class NotificationsRoute extends _i6.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(
          NotificationsRoute.name,
          path: 'notifications-view',
        );

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i5.QiblahView]
class QiblahRoute extends _i6.PageRouteInfo<void> {
  const QiblahRoute()
      : super(
          QiblahRoute.name,
          path: 'qiblah-view',
        );

  static const String name = 'QiblahRoute';
}

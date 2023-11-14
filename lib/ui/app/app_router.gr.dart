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
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../views/calendar.dart' as _i8;
import '../views/home/home.dart' as _i5;
import '../views/main_view.dart' as _i4;
import '../views/qiblah_view.dart' as _i7;
import '../views/quran.dart' as _i9;
import '../views/settings/location_view.dart' as _i2;
import '../views/settings/notifications_view.dart' as _i6;
import '../views/settings/search.dart' as _i3;
import '../views/settings/settings_page.dart' as _i1;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    SettingsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SettingsView(),
      );
    },
    LocationRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LocationView(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SearchView(),
      );
    },
    MainRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.MainView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomeView(),
      );
    },
    NotificationsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.NotificationsView(),
      );
    },
    QiblahRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.QiblahView(),
      );
    },
    HijriCalendarPage.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.HijriCalendarPage(),
      );
    },
    QuranRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.QuranView(),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          SettingsRoute.name,
          path: '/settings-view',
        ),
        _i10.RouteConfig(
          LocationRoute.name,
          path: '/location-view',
        ),
        _i10.RouteConfig(
          SearchRoute.name,
          path: '/search-view',
        ),
        _i10.RouteConfig(
          MainRoute.name,
          path: '/',
          children: [
            _i10.RouteConfig(
              HomeRoute.name,
              path: 'home-view',
              parent: MainRoute.name,
            ),
            _i10.RouteConfig(
              NotificationsRoute.name,
              path: 'notifications-view',
              parent: MainRoute.name,
            ),
            _i10.RouteConfig(
              QiblahRoute.name,
              path: 'qiblah-view',
              parent: MainRoute.name,
            ),
            _i10.RouteConfig(
              HijriCalendarPage.name,
              path: 'hijri-calendar-page',
              parent: MainRoute.name,
            ),
            _i10.RouteConfig(
              QuranRoute.name,
              path: 'quran-view',
              parent: MainRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SettingsView]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: '/settings-view',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i2.LocationView]
class LocationRoute extends _i10.PageRouteInfo<void> {
  const LocationRoute()
      : super(
          LocationRoute.name,
          path: '/location-view',
        );

  static const String name = 'LocationRoute';
}

/// generated route for
/// [_i3.SearchView]
class SearchRoute extends _i10.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search-view',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i4.MainView]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i5.HomeView]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-view',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i6.NotificationsView]
class NotificationsRoute extends _i10.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(
          NotificationsRoute.name,
          path: 'notifications-view',
        );

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [_i7.QiblahView]
class QiblahRoute extends _i10.PageRouteInfo<void> {
  const QiblahRoute()
      : super(
          QiblahRoute.name,
          path: 'qiblah-view',
        );

  static const String name = 'QiblahRoute';
}

/// generated route for
/// [_i8.HijriCalendarPage]
class HijriCalendarPage extends _i10.PageRouteInfo<void> {
  const HijriCalendarPage()
      : super(
          HijriCalendarPage.name,
          path: 'hijri-calendar-page',
        );

  static const String name = 'HijriCalendarPage';
}

/// generated route for
/// [_i9.QuranView]
class QuranRoute extends _i10.PageRouteInfo<void> {
  const QuranRoute()
      : super(
          QuranRoute.name,
          path: 'quran-view',
        );

  static const String name = 'QuranRoute';
}

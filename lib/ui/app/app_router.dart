import 'package:auto_route/auto_route.dart';
import 'package:test_app/ui/views/home/home.dart';
import 'package:test_app/ui/views/main_view.dart';
import 'package:test_app/ui/views/settings/notifications_view.dart';
import 'package:test_app/ui/views/settings/settings_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SettingsView),
    AutoRoute(page: MainView, initial: true, children: [
      AutoRoute(page: HomeView),
      AutoRoute(page: NotificationsView),
    ]),
  ],
)
class $AppRouter {}

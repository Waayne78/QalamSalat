import 'package:Qalam/ui/views/quran.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Qalam/ui/views/home/home.dart';
import 'package:Qalam/ui/views/main_view.dart';
import 'package:Qalam/ui/views/settings/notifications_view.dart';
import 'package:Qalam/ui/views/calendar.dart' as cal;
import 'package:Qalam/ui/views/settings/location_view.dart';
import 'package:Qalam/ui/views/settings/settings_page.dart';
import 'package:Qalam/ui/views/settings/search.dart';
import '../views/qiblah_view.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SettingsView),
    AutoRoute(page: LocationView),
    AutoRoute(page: SearchView),
    AutoRoute(page: MainView, initial: true, children: [
      AutoRoute(page: HomeView),
      AutoRoute(page: NotificationsView),
      AutoRoute(page: QiblahView),
      AutoRoute(page: cal.HijriCalendarPage),
      AutoRoute(page: QuranView),
    ]),
  ],
)
class $AppRouter {}

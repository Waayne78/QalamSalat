import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_app/ui/app/app_router.gr.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test_app/ui/app/app_theme.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      lazyLoad: false,
      resizeToAvoidBottomInset: false,
    animationDuration: const Duration(seconds: 0) ,
      routes: [HomeRoute(), NotificationsRoute(), NotificationsRoute()],
      bottomNavigationBuilder: (context, tabsRouter) => Container(
          color: AppTheme.lightColor,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: GNav(
            color: Colors.black,
            activeColor: AppTheme.primaryColor,
            tabBackgroundColor: AppTheme.darkColor,
            gap: 7,
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
            tabs: [
              GButton(
                icon: Icons.timer,
                text: 'Horaires',
                onPressed: () {
                    tabsRouter.setActiveIndex(0);
                  }
              ),
              GButton(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  onPressed: () {
                    tabsRouter.setActiveIndex(1);
                  }),
              GButton(
                icon: Icons.north_east,
                text: 'Qibla',
                onPressed: () {
                    tabsRouter.setActiveIndex(2);
                  }
              ),
            ],
          )),
    );
  }
}

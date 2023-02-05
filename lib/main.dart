import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/ui/app/app_router.gr.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/ui/app/app_theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Qalam',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('fr', 'FR'),
      ],
    );
  }
}

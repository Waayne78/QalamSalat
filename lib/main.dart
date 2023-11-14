import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Qalam/ui/app/app_router.gr.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Demander l'autorisation de localisation
  await _checkLocationPermission();

  runApp(ProviderScope(child: MyApp()));
}

Future<void> _checkLocationPermission() async {
  final locationPermissionStatus = await Geolocator.checkPermission();
  if (locationPermissionStatus == LocationPermission.denied ||
      locationPermissionStatus == LocationPermission.deniedForever) {
    await Geolocator.requestPermission();
  }
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

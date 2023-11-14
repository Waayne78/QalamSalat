import 'package:Qalam/ui/views/settings/location_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Qalam/ui/app/app_theme.dart';
import 'package:Qalam/ui/views/home/state/location_state.dart';
import 'package:geolocator/geolocator.dart';
import '../../app/app_router.gr.dart';

class LocationView extends ConsumerWidget {
  const LocationView({
    Key? key,
  }) : super(key: key);

  Widget buildLocationButton(
    BuildContext context,
    String text,
    bool isUsingGPS,
    void Function(bool) onTap,
    LocationState state,
  ) {
    final isSelected = state.isUsingGPS == isUsingGPS;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () async {
          if (!isUsingGPS) {
            final status = await Geolocator.requestPermission();
            if (status == LocationPermission.denied ||
                status == LocationPermission.deniedForever) {
              return;
            }
          }

          onTap(isUsingGPS);

          if (!isUsingGPS) {
            AutoRouter.of(context).push(SearchRoute());
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple : AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            text,
            style: GoogleFonts.ptSans(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: isSelected ? AppTheme.lightColor : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationProvider);
    return Scaffold(
      backgroundColor: AppTheme.lightColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightColor,
        centerTitle: true,
        title: Text(
          'Qalam®',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkColor,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Opacity(
              opacity: 0.6,
              child: IgnorePointer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "localisation".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: AppTheme.darkColor,
                        ),
                      ),
                    ),
                    Text(
                      "( Bientôt disponible )".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.darkColor,
                      ),
                    ),
                    SizedBox(height: 15),
                    buildLocationButton(
                      context,
                      "Utiliser le GPS",
                      true,
                      (value) {
                        ref
                            .read(locationProvider.notifier)
                            .setLocationChoice(value);
                      },
                      state,
                    ),
                    SizedBox(height: 10),
                    buildLocationButton(
                      context,
                      "Définir manuellement",
                      false,
                      (value) {
                        ref
                            .read(locationProvider.notifier)
                            .setLocationChoice(value);
                      },
                      state,
                    ),
                    SizedBox(height: 380),
                  ],
                ),
              ))),
    );
  }
}

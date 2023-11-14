import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:Qalam/ui/app/app_router.gr.dart';
import 'package:Qalam/ui/app/app_theme.dart';
import 'package:Qalam/ui/views/home/home_viewmodel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_route/auto_route.dart';
import '../../app/qalam_button.dart';
import 'package:Qalam/services/prayer_service.dart';

class LocationDisclosureDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autorisation de la Localisation requise'),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), 
      ),
      backgroundColor: AppTheme.primaryColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nous avons besoin de votre permission pour accéder à votre localisation.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            "Cette autorisation est nécessaire pour vous fournir les horaires de prière. Soyez assuré(e) que nous ne collectons aucune donnée personnelle.",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(context, true), // Accepter la permission
          child: Text('J\'accepte'),
        ),
      ],
    );
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  Widget buildPrayerTile(String name, String horaire) {
    return Container(
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(23),
        ),
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name.toUpperCase(),
                style: GoogleFonts.ptSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                horaire,
                style: GoogleFonts.farro(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(homeProvider);

    final df = DateFormat("EE d MMM yyyy", "fr_fr");
    final prettyDate = df.format(state.dateChoisie);

    final prayerServiceProvider = Provider((ref) => PrayerService());

    return Scaffold(
      backgroundColor: AppTheme.lightColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightColor,
        elevation: 0,
        title: Text('Qalam',
            style: GoogleFonts.cormorantGaramond(
                color: AppTheme.darkColor,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        actions: [
          GestureDetector(
            // Utilisez GestureDetector pour détecter le clic sur l'icône.
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LocationDisclosureDialog();
                },
              );
            },
            child: Icon(
              Icons.info, // Assurez-vous que vous utilisez la bonne icône ici.
              color: AppTheme.darkColor,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {
              AutoRouter.of(context).push(SettingsRoute());
            },
            icon: Icon(
              Icons.settings,
              color: AppTheme.darkColor,
              size: 25,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          DigitalClock(
            showSecondsDigit: false,
            digitAnimationStyle: Curves.easeOutQuart,
            hourMinuteDigitTextStyle: GoogleFonts.ptSans(
                color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Text(
            state.nextPrayer.toUpperCase(),
            style: GoogleFonts.ptSans(
                color: AppTheme.darkColor,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
          Text(
            (state.countdown / 60).floor() == 0 && state.countdown % 60 == 0
                ? 'MAINTENANT'
                : ((state.countdown / 60).floor() == 0
                    ? '${state.countdown % 60 + 1} MINUTES'
                    : '${(state.countdown / 60).floor()} HEURES ET ${state.countdown % 60 + 1} MINUTES'),
            style:
                GoogleFonts.ptSans(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QalamButton(
                  child: Icon(Icons.arrow_back_ios_outlined,
                      color: Colors.black, size: 17),
                  onPressed: () {
                    ref.read(homeProvider.notifier).lastDay();
                  },
                  color: AppTheme.lightColor,
                ),
                QalamButton(
                  child: Text(prettyDate,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2024),
                      locale: Locale("fr", "FR"),
                    );
                    if (date != null) {
                      ref.read(homeProvider.notifier).selectDate(date);
                      await ref.read(prayerServiceProvider).getPrayers(date);
                    }
                  },
                  color: AppTheme.primaryColor,
                ),
                QalamButton(
                  onPressed: () {
                    ref.read(homeProvider.notifier).nextDay();
                  },
                  color: AppTheme.lightColor,
                  child: Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.black, size: 17),
                ),
              ],
            ),
          ),
          state.horaires.isEmpty
              ? Container(
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppTheme.primaryColor,
                      size: 100,
                    ),
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPrayerTile("Subh", state.horaires[0]),
                        buildPrayerTile("Shuruq", state.horaires[1]),
                        buildPrayerTile("Dhuhr", state.horaires[2]),
                        buildPrayerTile("Asr", state.horaires[3]),
                        buildPrayerTile("Maghrib", state.horaires[4]),
                        buildPrayerTile("Isha", state.horaires[5]),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

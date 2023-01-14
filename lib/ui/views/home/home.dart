import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:test_app/ui/app/app_router.gr.dart';
import 'package:test_app/ui/app/app_theme.dart';
import 'package:test_app/ui/views/home/state/home_viewmodel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_route/auto_route.dart';
import '../../app/qalam_button.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name.toUpperCase(),
                style: GoogleFonts.ptSans(
                    fontSize: 19, fontWeight: FontWeight.bold),
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
    final state = ref.watch(homeProvider);

    final df = DateFormat("EE d MMM yyyy", "fr_fr");
    final prettyDate = df.format(state.dateChoisie);

    return Scaffold(
        backgroundColor: AppTheme.lightColor,
        appBar: AppBar(
          backgroundColor: AppTheme.lightColor,
          elevation: 0,
          title: Text('Qalam',
              style: GoogleFonts.cormorantGaramond(
                  color: Color.fromARGB(255, 147, 0, 173),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              onPressed: () {
                AutoRouter.of(context).push(SettingsRoute());
              },
              icon: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 147, 0, 173),
                size: 25,
              ),
            ),
          ],
        ),
        body: Column(children: <Widget>[
          DigitalClock(
            showSecondsDigit: false,
            digitAnimationStyle: Curves.easeOutQuart,
            areaDecoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            hourMinuteDigitTextStyle: GoogleFonts.farro(
                color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
            hourMinuteDigitDecoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
          ),
          Text(
            state.nextPrayer.toUpperCase(),
            style: GoogleFonts.ptSans(
                color: Color.fromARGB(255, 147, 0, 173),
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          Text(
              ' DANS ${(state.countdown / 60).floor()} HEURES ET ${state.countdown % 60} MINUTES',
              style: GoogleFonts.ptSans(fontSize: 15)),
          const SizedBox(height: 8),
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
                          lastDate: DateTime(2025),
                          locale: Locale("fr", "FR"));
                      if (date != null) {
                        ref.read(homeProvider.notifier).selectDate(date);
                      }
                    },
                    color: AppTheme.primaryColor),
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
          const SizedBox(height: 5, width: 50),
          state.horaires.isEmpty
              ? Container(
                  child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppTheme.primaryColor,
                    size: 100,
                  ),
                ))
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPrayerTile("Subh", state.horaires[0]),
                        buildPrayerTile("Shuruq", state.horaires[1]),
                        buildPrayerTile("Dhur", state.horaires[2]),
                        buildPrayerTile("Asr", state.horaires[3]),
                        buildPrayerTile("Maghrib", state.horaires[4]),
                        buildPrayerTile("Isha", state.horaires[5]),
                      ],
                    ),
                  ),
                ),
        ]));
  }
}

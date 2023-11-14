import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Qalam/services/prayer_service.dart';
import 'state/home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  final StateNotifierProviderRef<HomeNotifier, HomeState> _ref;

  HomeNotifier(this._ref) : super(HomeState.initial()) {
    selectDate(DateTime.now(), today: true);
    nextPrayerLoop();
  }

  void selectDate(DateTime date, {bool today = false}) async {
    state = state.copyWith(dateChoisie: date, horaires: []);
    final horaires = await _ref.read(prayerServiceProvider).getPrayers(date);
    state = state.copyWith(horaires: horaires);

    if (today) {
      state = state.copyWith(horairesToday: horaires);
    }
  }

  void lastDay() {
    final hier = state.dateChoisie.add(const Duration(days: -1));
    selectDate(hier);
  }

  void nextDay() {
    final demain = state.dateChoisie.add(const Duration(days: 1));
    selectDate(demain);
  }

  void nextPrayerLoop() async {
    while (true) {
      final nombreMaintenant =
          "${DateTime.now().hour}${DateTime.now().minute.toString().padLeft(2, '0')}";

      if (state.horairesToday.isEmpty) {
        await Future.delayed(Duration(seconds: 2));
        continue;
      }

      int indice = 0;
      for (var horaire in state.horairesToday) {
        horaire = horaire.replaceAll(":", "");
        if (int.parse(nombreMaintenant) > int.parse(horaire)) {
          indice += 1;
        } else {
          break;
        }
      }

      if (indice >= state.horairesToday.length) {
        // Toutes les prières pour aujourd'hui sont déjà passées,
        // passons à la première prière de demain
        final demain = DateTime.now().add(Duration(days: 1));
        final keyDemain = demain.toString().split(" ")[0];
        final horairesDemain =
            _ref.read(prayerServiceProvider).prayerCache[keyDemain]!;
        final nextPrayer = horairesDemain[0].split(":")[0];
        final nextPrayerTime = DateTime(
          demain.year,
          demain.month,
          demain.day,
          int.parse(horairesDemain[0].split(":")[0]),
          int.parse(horairesDemain[0].split(":")[1]),
        );
        final timeLeft = nextPrayerTime.difference(DateTime.now()).inMinutes;
        state = state.copyWith(nextPrayer: nextPrayer, countdown: timeLeft);
      } else {
        final nextPrayer =
            ["Subh", "Shuruq", "Dhuhr", "Asr", "Maghrib", "Isha"][indice];
        final nextPrayerInfo = state.horairesToday[indice].split(":");
        final nextPrayerTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          int.parse(nextPrayerInfo[0]),
          int.parse(nextPrayerInfo[1]),
        );
        final timeLeft = nextPrayerTime.difference(DateTime.now()).inMinutes;
        state = state.copyWith(nextPrayer: nextPrayer, countdown: timeLeft);
      }

      // Notify listeners to update the UI

      await Future.delayed(Duration(seconds: 2));
    }
  }
}

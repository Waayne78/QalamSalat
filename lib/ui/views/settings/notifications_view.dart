import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Qalam/ui/app/app_theme.dart';

enum Adhan {
  adhan1,
  adhan2,
  adhan3,
  adhan4,
}

class NotificationsState {
  bool subh;
  bool dhuhr;
  bool asr;
  bool maghrib;
  bool isha;
  Adhan adhan;

  NotificationsState({
    this.subh = true,
    this.dhuhr = true,
    this.asr = true,
    this.maghrib = true,
    this.isha = true,
    this.adhan = Adhan.adhan1,
  });

  NotificationsState copyWith({
    bool? subh,
    bool? dhuhr,
    bool? asr,
    bool? maghrib,
    bool? isha,
    Adhan? adhan,
  }) {
    return NotificationsState(
      subh: subh ?? this.subh,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
      adhan: adhan ?? this.adhan,
    );
  }
}

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  NotificationsNotifier() : super(NotificationsState());

  void setSubh(bool value) {
    state = state.copyWith(subh: value);
  }

  void setDhuhr(bool value) {
    state = state.copyWith(dhuhr: value);
  }

  void setAsr(bool value) {
    state = state.copyWith(asr: value);
  }

  void setMaghrib(bool value) {
    state = state.copyWith(maghrib: value);
  }

  void setIsha(bool value) {
    state = state.copyWith(isha: value);
  }

  void setAdhan(Adhan adhan) {
    state = state.copyWith(adhan: adhan);
  }
}

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  return NotificationsNotifier();
});

class NotificationsView extends ConsumerWidget {
  const NotificationsView({Key? key});
  Widget buildNotifTile(
    String text,
    bool value,
    IconData icone,
    Function(bool) onChanged,
  ) {
    IconData notificationIcon =
        value ? Icons.notifications : Icons.notifications_off;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text.toUpperCase(),
                  style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            IconButton(
              icon: Icon(notificationIcon, size: 25),
              onPressed: () => onChanged(!value),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsProvider);
    final notifier = ref.read(notificationsProvider.notifier);

    return Scaffold(
      backgroundColor: AppTheme.lightColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightColor,
        centerTitle: true,
        title: Text(
          'Qalam',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkColor,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
          child: Opacity(
              opacity: 0.6,
              child: IgnorePointer(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "(Bientôt disponible)".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: AppTheme.darkColor,
                          ),
                        ),
                        SizedBox(height: 50),
                        buildNotifTile(
                          "SUBH",
                          state.subh,
                          Icons.notifications,
                          (value) => notifier.setSubh(value),
                        ),
                        buildNotifTile(
                          "DHUHR",
                          state.dhuhr,
                          Icons.notifications,
                          (value) => notifier.setDhuhr(value),
                        ),
                        buildNotifTile(
                          "ASR",
                          state.asr,
                          Icons.notifications,
                          (value) => notifier.setAsr(value),
                        ),
                        buildNotifTile(
                          "MAGHRIB",
                          state.maghrib,
                          Icons.notifications,
                          (value) => notifier.setMaghrib(value),
                        ),
                        buildNotifTile(
                          "ISHA",
                          state.isha,
                          Icons.notifications,
                          (value) => notifier.setIsha(value),
                        ),
                        SizedBox(height: 140),
                      ],
                    ),
                  ),
                ),
              ))),
      floatingActionButton: IgnorePointer(
        ignoring: true,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Choisir l\'adhan'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                actions: [
                  TextButton(
                    child: Text('Annuler'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                backgroundColor: AppTheme.primaryColor,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<Adhan>(
                      title: Text('Adhan La Mecque'),
                      value: Adhan.adhan1,
                      groupValue: state.adhan,
                      onChanged: (value) {
                        notifier.setAdhan(value!);
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile<Adhan>(
                      title: Text('Adhan Médine'),
                      value: Adhan.adhan2,
                      groupValue: state.adhan,
                      onChanged: (value) {
                        notifier.setAdhan(value!);
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile<Adhan>(
                      title: Text('Adhan Al-Aqsa'),
                      value: Adhan.adhan3,
                      groupValue: state.adhan,
                      onChanged: (value) {
                        notifier.setAdhan(value!);
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile<Adhan>(
                      title: Text('Adhan Abdoul Bassit Abdussamad '),
                      value: Adhan.adhan4,
                      groupValue: state.adhan,
                      onChanged: (value) {
                        notifier.setAdhan(value!);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          child: Icon(Icons.mosque),
        ),
      ),
    );
  }
}

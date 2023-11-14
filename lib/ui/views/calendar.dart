import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Qalam/ui/app/app_theme.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  final Map<String, bool> prayerStatus;

  AppLifecycleObserver(this.prayerStatus);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _savePrayerStatus();
    }
  }

  Future<void> _savePrayerStatus() async {
    final prefs = await SharedPreferences.getInstance();
    for (final prayer in prayerStatus.keys) {
      final status = prayerStatus[prayer];
      if (status != null) {
        await prefs.setBool(prayer, status);
      }
    }
  }
}

class HijriCalendarPage extends StatefulWidget {
  @override
  _HijriCalendarPageState createState() => _HijriCalendarPageState();
}

class _HijriCalendarPageState extends State<HijriCalendarPage> {
  late HijriCalendar selectedDate;
  final Map<String, bool> prayerStatus = {
    'Subh': false,
    'Dhuhr': false,
    'Asr': false,
    'Maghrib': false,
    'Isha': false,
  };

  late AppLifecycleObserver appLifecycleObserver;

  @override
  void initState() {
    super.initState();
    selectedDate = HijriCalendar.now();
    _loadPrayerStatus();
    appLifecycleObserver = AppLifecycleObserver(prayerStatus);
    WidgetsBinding.instance.addObserver(appLifecycleObserver);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(appLifecycleObserver);
    _savePrayerStatus();
    super.dispose();
  }

  _loadPrayerStatus() async {
    final prefs = await SharedPreferences.getInstance();
    for (final prayer in prayerStatus.keys) {
      final status = prefs.getBool(prayer);
      if (status != null) {
        setState(() {
          prayerStatus[prayer] = status;
        });
      }
    }
  }

  _savePrayerStatus() async {
    final prefs = await SharedPreferences.getInstance();
    for (final prayer in prayerStatus.keys) {
      final status = prayerStatus[prayer];
      if (status != null) {
        await prefs.setBool(prayer, status);
      }
    }
  }

  final List<String> hijriMonthNames = [
    'Muharram',
    'Safar',
    'Rabi Al-Awwal',
    'Rabi Al-Thani',
    'Jumada Al-Awwal',
    'Jumada Al-Thani',
    'Rajab',
    'Shaaban',
    'Ramadan',
    'Shawwal',
    'Dhu Al-Qidah',
    'Dhu Al-Hijjah'
  ];

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final firstDate = HijriCalendar.fromDate(DateTime(1937, 3, 14));
    final lastDate = HijriCalendar.fromDate(DateTime(2077, 11, 16));
    final dateFormat = DateFormat('dd MMMM yyyy', 'fr_FR');
    final formattedDate = dateFormat.format(currentDate);

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
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                formattedDate,
                style: GoogleFonts.ptSans(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              HijriMonthPicker(
                firstDate: firstDate,
                lastDate: lastDate,
                selectedDate: selectedDate,
                onChanged: (newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
              Column(
                children: prayerStatus.keys
                    .map(
                      (prayer) => CheckboxListTile(
                        title: Text(
                          prayer.toUpperCase(),
                          style: GoogleFonts.ptSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        dense: true,
                        value: prayerStatus[prayer],
                        onChanged: (value) {
                          setState(() {
                            prayerStatus[prayer] = value!;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

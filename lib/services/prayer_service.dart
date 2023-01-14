import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final prayerServiceProvider = Provider((ref) => PrayerService());

class PrayerService {
  Map<String, List<String>> prayerCache = {};

  String _prettyPrayerTime(String time) {
    return time.split(" ")[0];
  }

  Future<List<String>> getPrayers(DateTime day) async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return [];
      }
    }

    final position = await Geolocator.getCurrentPosition();
    
    final key = day.toString().split(" ")[0];
    if (prayerCache.containsKey(key)) {
      return prayerCache[key]!;
    }

    final url = "https://api.aladhan.com/v1/calendar?latitude=${position.latitude}&longitude=${position.longitude}&method=2&month=${day.month}&year=${day.year}";
    final data = await http.get(Uri.parse(url));
    final json = jsonDecode(data.body);

    // Sauvegarde des horaires obtenues
    for (final jour in json["data"]) {
      final timestamp = jour["date"]["timestamp"];
      final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
      final dateString = date.toString().split(" ")[0];

      final horaires = jour["timings"];
      prayerCache[dateString] = [
        _prettyPrayerTime(horaires["Fajr"]),
        _prettyPrayerTime(horaires["Sunrise"]),
        _prettyPrayerTime(horaires["Dhuhr"]),
        _prettyPrayerTime(horaires["Asr"]),
        _prettyPrayerTime(horaires["Maghrib"]),
        _prettyPrayerTime(horaires["Isha"])
      ];
    }

    return prayerCache[day.toString().split(" ")[0]]!;
  }
}
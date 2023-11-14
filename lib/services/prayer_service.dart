import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final prayerServiceProvider = Provider((ref) => PrayerService());

class PrayerService {
  Map<String, List<String>> prayerCache = {};
  Position? userLocation;
  LocationPermission? locationPermissionStatus;

  Future<void> _saveUserLocation(Position location) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', location.latitude);
    prefs.setDouble('longitude', location.longitude);
  }

  Future<Position?> _getUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble('latitude');
    final longitude = prefs.getDouble('longitude');
    if (latitude != null && longitude != null) {
      // Utilisation des valeurs par défaut pour les autres propriétés
      return Position(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      );
    }
    return null;
  }

  Future<void> _checkLocationPermission(BuildContext context) async {
    // Vérifiez si la permission de géolocalisation a été accordée précédemment
    locationPermissionStatus = await Geolocator.checkPermission();
    if (locationPermissionStatus == LocationPermission.denied ||
        locationPermissionStatus == LocationPermission.deniedForever) {
      locationPermissionStatus = await Geolocator.requestPermission();
      if (locationPermissionStatus == LocationPermission.denied ||
          locationPermissionStatus == LocationPermission.deniedForever) {
        return;
      }
      // L'utilisateur a accordé la permission, enregistrez cette information
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('locationPermissionGranted', true);
    }
  }

  Future<void> _getStoredLocationPermission() async {
    // Vérifiez si l'utilisateur a déjà accordé la permission de localisation
    final prefs = await SharedPreferences.getInstance();
    final bool? permissionGranted = prefs.getBool('locationPermissionGranted');
    if (permissionGranted == true) {
      // L'utilisateur a déjà accordé la permission, pas besoin de demander à nouveau
      locationPermissionStatus = LocationPermission.whileInUse;
    }
  }

  // ignore: unused_element
  String _getPrettyNextPrayer(DateTime now, List<String> prayers) {
    final nowFormatted = DateFormat('HH:mm').format(now);

    // Vérifier si l'heure actuelle est après Isha
    if (nowFormatted.compareTo(prayers[5]) > 0) {
      // Si oui, afficher la prochaine prière comme étant Subh (Fajr) du jour suivant
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final tomorrowFormatted = DateFormat('yyyy-MM-dd').format(tomorrow);
      final tomorrowPrayers = prayerCache[tomorrowFormatted]!;
      return 'Subh (${tomorrowPrayers[0]})';
    } else {
      // Sinon, afficher la prochaine prière normalement
      for (int i = 0; i < prayers.length; i++) {
        if (nowFormatted.compareTo(prayers[i]) < 0) {
          switch (i) {
            case 0:
              return 'Subh';
            case 1:
              return 'Sunrise';
            case 2:
              return 'Dhuhr';
            case 3:
              return 'Asr';
            case 4:
              return 'Maghrib';
            case 5:
              return 'Isha';
          }
        }
      }
    }

    return 'Subh'; // Par défaut, retourner Fajr si aucune prière n'est trouvée (par exemple, si les horaires sont incorrects)
  }

  String _prettyPrayerTime(String time) {
    return time.split(" ")[0];
  }

  Future<List<String>> getPrayers(DateTime day) async {
    // Vérifiez si la permission de géolocalisation a été accordée
    if (locationPermissionStatus == null) {
      await _getStoredLocationPermission();
      if (locationPermissionStatus == null) {
        await _checkLocationPermission;
      }
    }
    if (userLocation == null) {
      userLocation = await _getUserLocation();

      if (userLocation == null) {
        userLocation = await Geolocator.getLastKnownPosition() ??
            await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.medium);

        if (userLocation != null) {
          _saveUserLocation(userLocation!);
        }
      }
    }

    final key = day.toString().split(" ")[0];
    if (prayerCache.containsKey(key)) {
      return prayerCache[key]!;
    }

    final url =
        "https://api.aladhan.com/v1/calendar?latitude=${userLocation!.latitude}&longitude=${userLocation!.longitude}&method=2&month=${day.month}&year=${day.year}";
    final data = await http.get(Uri.parse(url));
    final json = jsonDecode(data.body);

    // Sauvegarde des horaires obtenues
    for (final jour in json["data"]) {
      final timestamp = jour["date"]["timestamp"];
      final date =
          DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
      final dateString = date.toString().split(" ")[0];

      final horaires = jour["timings"];
      prayerCache[dateString] = [
        _prettyPrayerTime(horaires["Fajr"]),
        _prettyPrayerTime(horaires["Sunrise"]),
        _prettyPrayerTime(horaires["Dhuhr"]),
        _prettyPrayerTime(horaires["Asr"]),
        _prettyPrayerTime(horaires["Maghrib"]),
        _prettyPrayerTime(horaires["Isha"]),
      ];
    }

    return prayerCache[day.toString().split(" ")[0]]!;
  }
}

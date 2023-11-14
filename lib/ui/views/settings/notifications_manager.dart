/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:Qalam/services/prayer_service.dart';
import 'package:intl/intl.dart';

import 'package:timezone/timezone.dart' as tz;

class NotificationsManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final PrayerService prayerService =
      PrayerService(); // Créez une instance de PrayerService

  static String _prettyPrayerTime(String time) {
    return time.split(" ")[0];
  }

  static Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      // Gérer l'action lorsque l'utilisateur clique sur la notification (facultatif)
    });
  }

  Future<void> _showDailyPrayerNotification() async {
    final now = DateTime.now();
    final prayers = await prayerService.getPrayers(now);

    final nextPrayer = _getNextPrayer(now, prayers);
    final nextPrayerTime = _parsePrayerTime(nextPrayer, prayers);
    final notificationTime = nextPrayerTime.subtract(Duration(minutes: 15));

    // Convertir les dates et heures en utilisant le fuseau horaire par défaut
    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.from(notificationTime, tz.local);

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'daily_prayer_notification_channel',
      'Daily Prayer Notifications',
      'Notifications for daily prayers',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Prochaine prière',
      'C\'est l\'heure de ${nextPrayer.toLowerCase()} !',
      scheduledDate, // Utiliser le TZDateTime ici
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily_prayer',
    );
  }

  static String _getNextPrayer(DateTime now, List<String> prayers) {
    final nowFormatted = DateFormat('HH:mm').format(now);

    // Vérifier si l'heure actuelle est après Isha
    if (nowFormatted.compareTo(prayers[5]) > 0) {
      // Si oui, la prochaine prière est Fajr du jour suivant
      final tomorrow = now.add(Duration(days: 1));
      final tomorrowFormatted = DateFormat('yyyy-MM-dd').format(tomorrow);
      final tomorrowPrayers = PrayerService().prayerCache[tomorrowFormatted]!;
      return 'Fajr (${_prettyPrayerTime(tomorrowPrayers[0])})';
    } else {
      // Sinon, rechercher la prochaine prière dans les horaires de prière
      for (int i = 0; i < prayers.length; i++) {
        if (nowFormatted.compareTo(prayers[i]) < 0) {
          switch (i) {
            case 0:
              return 'Fajr (${_prettyPrayerTime(prayers[0])})';
            case 1:
              return 'Sunrise (${_prettyPrayerTime(prayers[1])})';
            case 2:
              return 'Dhuhr (${_prettyPrayerTime(prayers[2])})';
            case 3:
              return 'Asr (${_prettyPrayerTime(prayers[3])})';
            case 4:
              return 'Maghrib (${_prettyPrayerTime(prayers[4])})';
            case 5:
              return 'Isha (${_prettyPrayerTime(prayers[5])})';
          }
        }
      }
    }

    return 'Fajr (${_prettyPrayerTime(prayers[0])})'; // Par défaut, retourner Fajr si aucune prière n'est trouvée (par exemple, si les horaires sont incorrects)
  }

  static DateTime _parsePrayerTime(String prayer, List<String> prayers) {
    //  logique pour obtenir l'heure de la prière spécifiée
    // Ici, je vais simplement renvoyer l'heure actuelle comme exemple
    return DateTime.now();
  }

  Future<void> setupNotifications() async {
    await initNotifications();
    await _showDailyPrayerNotification();
  }
}*/

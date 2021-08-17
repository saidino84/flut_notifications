// import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:timezone/data/latest.dart' as tz;

class AppNotificationService {
  static final AppNotificationService _notificationService =
      AppNotificationService._internal();

  factory AppNotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin local_notity_plugn =
      FlutterLocalNotificationsPlugin();

  //construtor singleton
  AppNotificationService._internal();

  Future<void> init_notification_plugin() async {
    final AndroidInitializationSettings initilizationsAndroidSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initilizations_ios =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);
    final InitializationSettings initsettingsplatform = InitializationSettings(
        android: initilizationsAndroidSetting, iOS: initilizations_ios);

    await local_notity_plugn.initialize(initsettingsplatform);
  }

  // fuction which will show the notifications

  Future<void> show_notification(
      int id, String title, String body, int seconds) async {
    await local_notity_plugn.zonedSchedule(
      id,
      title,
      body,
      // scheduledDate,,
      timezone.TZDateTime.now(timezone.local).add(
        Duration(seconds: seconds),
      ),
      // notificationDetails,
      NotificationDetails(
        android: AndroidNotificationDetails(
            'main_chanel', 'Main chanel', 'Main Chanel notification',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/ic_launcher'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> canceAllNotification() async {
    local_notity_plugn.cancelAll();
  }
}

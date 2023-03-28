import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Initialize the FlutterLocalNotificationsPlugin.
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Configure the Android notification settings.
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configure the iOS notification settings.
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    // Configure the initialization settings for the plugin.
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize the plugin.
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request permission to display notifications.
    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    tz.initializeTimeZones();
  }

  static Future<void> scheduleNotification(DateTime scheduledTime, String title,
      String body, DateTime scheduledDate) async {
    const androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel id', 'channel name',
            // 'channel description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            channelDescription: 'channel description');

    final iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // final DateTime notifDate =
    //     scheduledDate.subtract(const Duration(minutes: 15));
    print('here is the date!!!!!!------!!!!!!');
    print(scheduledDate);
    DateTime combinedDateTime = DateTime(
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledTime.hour,
      scheduledTime.minute,
      scheduledTime.second,
    );
    final scheduledNotificationDate =
        tz.TZDateTime.from(combinedDateTime, tz.local);

    print(scheduledNotificationDate);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0, title, body, scheduledNotificationDate, platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

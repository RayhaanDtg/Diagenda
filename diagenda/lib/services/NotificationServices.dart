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
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

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

  static Future<void> scheduleNotification(
      DateTime scheduledDate, String title, String body) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      // Add the following line to set the flag for the PendingIntent.
      // pendingIntent: PendingIntent.getActivity(
      //   context,
      //   0,
      //   intent,
      //   PendingIntentFlag.immutable // Use the immutable flag for targeting Android S+ (version 31 and above).
      // ),
    );

    final iOSPlatformChannelSpecifics = IOSNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // final DateTime notifDate =
    //     scheduledDate.subtract(const Duration(minutes: 15));
    final scheduledNotificationDate =
        tz.TZDateTime.from(scheduledDate, tz.local);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0, title, body, scheduledNotificationDate, platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

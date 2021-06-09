import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<NotificationService> notificationServiceProvider =
    Provider<NotificationService>(
        (ProviderReference ref) => NotificationService());

class NotificationService {
  NotificationService() : settings = initializeNotificationsSettings();

  late FlutterLocalNotificationsPlugin plugin;
  final InitializationSettings settings;

  static InitializationSettings initializeNotificationsSettings() {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    return const InitializationSettings(android: initializationSettingsAndroid);
  }

  Future<void> initializePlugin(
      [Future<dynamic> Function(String?)? callback]) async {
    plugin = FlutterLocalNotificationsPlugin()
      ..initialize(settings, onSelectNotification: callback);
  }

  Future<void> showNotification(
      [Future<dynamic> Function(String?)? callback]) async {
    await initializePlugin((_) async {
      debugPrint('Callback started');
      await callback?.call('');
    });
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            fullScreenIntent: true);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await plugin.show(0, 'title', 'body', platformChannelSpecifics);
  }
}

// class NotificationService {
//   factory NotificationService() {
//     return _notificationService;
//   }
//   NotificationService._internal();

//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   static const channelId = 'VaccinationBotNotificationID';
//   static const channelName = 'Vaccination Bot Notification';
//   static const channelDescription =
//       'This Notification alerts the user that a new vaccination appointment is available';

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//         await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

//     if (!(notificationAppLaunchDetails?.didNotificationLaunchApp ?? false)) {
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');

//       const InitializationSettings initializationSettings =
//           InitializationSettings(
//               android: initializationSettingsAndroid, iOS: null, macOS: null);
//       await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//           onSelectNotification: (payload) async {
//         print('START THE CALLBACK');
//         if (payload != null) {
//           selectNotification(payload);
//         }
//       });
//     }
//   }

//   Future<dynamic> selectNotification(String? payload) async {
//     if (payload != null) {
//       final String path = payload;
//       await pushRoute(path);
//     }
//   }

//   Future<void> showNotification(String routePath) async {
//     print('show notif');
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'Title',
//         'Body',
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//                 channelId, channelName, channelDescription)),
//         payload: routePath);
//   }
// }

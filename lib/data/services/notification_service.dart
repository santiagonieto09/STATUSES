import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static const int _notificationId = 1000;
  static const String _channelId = 'new_statuses';
  static const String _channelName = 'Nuevos estados';
  static const String _channelDescription = 'Notificaciones cuando hay nuevos estados disponibles';

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  void _onNotificationTap(NotificationResponse response) {
    if (response.payload == '/home') {
      // The app will be opened by default when tapping a notification;
      // payload can be used for deeper navigation in the future
    }
  }

  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? false;
    }
    return true;
  }

  Future<void> showGroupedNotification(int newCount, String body) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      groupKey: 'new_statuses',
      setAsGroupSummary: true,
      icon: '@mipmap/ic_launcher',
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    await _plugin.show(
      _notificationId,
      'Statuses',
      body,
      details,
      payload: '/home',
    );
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}

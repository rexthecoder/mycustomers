import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notifications_service.dart';

class NotificationRemindersServiceImpl extends NotificationRemindersService {
  var flutterLocalNotificationsPlugin;

  NotificationRemindersServiceImpl() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  void initNotifications() {
    // Sets icon to be displayed with notification (android).
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    // Intialization requires two arguments, for IOS and Android. IOS requires more , but that hasn't been set yet.
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  dynamic pendingNotificationRequests() async =>
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();


  void sendNotificationDaily(
      {int id, String title, String body, int hour, int minute}) async {
    var time = new Time(hour, minute, 0);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, getPlatformChannelSpecifics(id));

    print(
        'Notification Succesfully Scheduled for ${time.toString()} with id of $id');
  }

  void sendNotificationOnce(
      int id, String title, String body, DateTime time) async {
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, time, getPlatformChannelSpecifics(id));

    print(
        'Notification Succesfully Scheduled for ${time.toString()} with id of $id');
  }

  getPlatformChannelSpecifics(int id) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '$id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    // await Navigator.pushNamed(context,
    // screen name goes here
    // );
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
    print('Notfication with id: $notificationId been removed successfully');
  }
}

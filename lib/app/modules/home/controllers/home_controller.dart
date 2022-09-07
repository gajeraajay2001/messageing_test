import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class HomeController extends GetxController {
  RxInt count = 0.obs;
  @override
  void onInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification notification = message.notification!;
        AndroidNotification android = message.notification!.android!;
        if (notification != null && android != null) {
          showDialog(
              context: Get.context!,
              builder: (_) {
                return AlertDialog(
                  title: Text(notification.title!),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(notification.body!)],
                    ),
                  ),
                );
              });
        }
      });
    });
    super.onInit();
  }

  sendMessage() {
    count.value++;
    flutterLocalNotificationsPlugin.show(
        0,
        "I Am Ajay.......",
        "Heyyy Bro Body",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.teal,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

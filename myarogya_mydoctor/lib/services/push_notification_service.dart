import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

//   Replace with server token from firebase console settings.
  final String serverToken = "FMdhwduAXmTweo_7sH5ACMtw:APA91bF_TtfpKNR3RRLfXlZF9CDC-cnxXn5k-dVTqQORGB3LbM80FxD9hPUYXGMBTYeu5GPQSDZdQoeXdPgUOiGfheyh9D_O4Jy-SFB--5nJ4fPOOvoRXSKmpfbDAVUu3EyTjPbRi7uW";
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    // await firebaseMessaging.requestNotificationPermissions(
    //   const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    // );
    firebaseMessaging.requestNotificationPermissions(
    );
    print("start send!!");
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a sample1',
            'title': 'this is a testing'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '11',
            'status': 'done'
          },
          'to': await firebaseMessaging.getToken(),
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
        print("onMessage: $message");
        print(await firebaseMessaging.getToken());
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        completer.complete(message);
        print(message);
        print("onResume: $message");
      },

    );

    return completer.future;
  }
}
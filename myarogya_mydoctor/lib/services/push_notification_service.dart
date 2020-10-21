import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
//  final FirebaseMessaging _fcm = FirebaseMessaging();
//  Future initialise() async {
//
//    _fcm.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("onMessage: $message");
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print("onLaunch: $message");
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("onResume: $message");
//      },
//    );
//  }

//   Replace with server token from firebase console settings.
  final String serverToken = 'AAAA7eatpRE:APA91bH_jn9HzOOvWRjJ3bPR_rb9Bu_4FKyPbXZBSVKqUVtchzCCLygY_L3q85Pf2aZUK_4za2wO3oqFFgJ0TtNMLpHJ5UDRKAf2QB00U078AOz_kA0cyv3YoCQrsS9sVFP1pcqJvgl2';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
//    await firebaseMessaging.requestNotificationPermissions(
////      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
//    );
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
        print(message);
        print(await firebaseMessaging.getToken());
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },

    );

    return completer.future;
  }
}
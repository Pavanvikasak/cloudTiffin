import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
// import 'package:demopatient/config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import 'handleLocalNotification.dart';

class HandleFirebaseNotification {
  //String firebaseServerKey ='AAAAwz1Sw1A:APA91bEEwu6XEeoSZuJA0AULRqYtuPNZFLgfEfYCEPDFJt1KTf0XmJsUO6nR0XP-JQf2jOYMZ8TBQ2Hcyq9d54VSEamaBpL8W0zGNfIeDnMHbtnfMIXaES6-HV_2XEfz0sx5u8F0pbYN';

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (Firebase.apps.isEmpty) await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  static handleNotifications(context) async {
    await FirebaseMessaging.instance.subscribeToTopic(
        "all"); // subscribed user to all group, so user will be received notification when admin send to all group
    print("========================user subscribed=============");
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        badge: true,
        alert: true,
        sound:
            true); //presentation options for Apple notifications when received in the foreground.

    FirebaseMessaging.onMessage.listen((message) async {
      print('Got a message whilst in the FOREGROUND!');

      return;
    }).onData((data) {
      print("GGGGGGGGGGGGGGGGGGGGGGGGGGGGG");
      print("GGGGGGGGGGGGGGGGGGGGGGGGGGGGG ${data.data}");
      HandleLocalNotification.showNotification(
          data.data['title'], data.data['body']);
      print('Got a DATA message whilst in the FOREGROUND!');
      print('data from stream: ${data.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('NOTIFICATION MESSAGE TAPPED');
      return;
    }).onData((data) {
      print('NOTIFICATION MESSAGE TAPPED');
      print('data from stream: ${data.data}');
      // Navigator.pushNamed(
      //   context,
      //   "/NotificationPage",
      // );
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage().then(
        (value) => value != null ? _firebaseMessagingBackgroundHandler : false);
    return;
  }

  static Future<void> sendPushMessage(
      String token, String title, String body) async {
    // String firebaseServerKey ='AAAAwz1Sw1A:APA91bEEwu6XEeoSZuJA0AULRqYtuPNZFLgfEfYCEPDFJt1KTf0XmJsUO6nR0XP-JQf2jOYMZ8TBQ2Hcyq9d54VSEamaBpL8W0zGNfIeDnMHbtnfMIXaES6-HV_2XEfz0sx5u8F0pbYN';
    String firebaseServerKey =
        'AAAA3gzlv4s:APA91bHgAdfUyzop6hTplmQzeIU5m2gxgelt4Z93pabFsVi63NQ__rcfnDM6QA6BeFpGpSBedjYX6l0RGB313L3Ele3xAuE5ReKyzeaiB0BkyYY9omJ5w53Ou-jJi9vPtUTEhmY3JjKX';
    String serverKey = firebaseServerKey;
    String _token = token;
    // if (_token == null) {
    //   print('Unable to send FCM message, no token exists.');
    //   return;
    // }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey'
        },
        body: constructFCMPayload(_token, title, body),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  static String constructFCMPayload(
    String token,
    String title,
    String body,
  ) {
    return jsonEncode({
      "to": token,
      "notification": {
        "sound": "default",
        "body": body,
        "title": title,
        "content_available": true,
        "priority": "high"
      },
      "data": {
        "sound": "default",
        "body": body,
        "title": title,
        "content_available": true,
        "priority": "high"
      }
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:market_app_bot/src/view/screen.dart';

void main() async {FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.init(androidNotificationOptions: AndroidNotificationOptions(channelId: "schedule_channel",
        channelName: "scheduled_channel"), iosNotificationOptions: IOSNotificationOptions(showNotification: true),
        foregroundTaskOptions: ForegroundTaskOptions(eventAction: ForegroundTaskEventAction.repeat(2)));
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

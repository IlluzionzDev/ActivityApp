import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'home.dart';

void main() {
  // Listen for state change on our model to update activities in application
  runApp(App());

  // Allow notification library
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid = AndroidInitializationSettings("app_icon");
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

/// Main application Widget, our display screen
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      // Provide widgets with our ActivityModel
      create: (context) => ActivityModel(),
      child: MaterialApp(
        title: 'Activities',
        theme: ThemeData(fontFamily: 'OpenSans'),
        home: Home(),
      ),
    );
  }
}
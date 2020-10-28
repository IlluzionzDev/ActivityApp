import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/activity/timer/custom_timer.dart';
import 'package:intl/intl.dart';

import '../colours.dart';

class AnalyticsScreen extends StatefulWidget {

  final Activity activity;
  AnalyticsScreen(this.activity);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState(this.activity);
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {

  final Activity activity;
  _AnalyticsScreenState(this.activity);

  @override
  Widget build(BuildContext context) {
    CustomTimer timer = CustomTimer.preset(activity.analytics.getAverageCompletion());
    final now = new DateTime.now();
    DateTime storedTime = new DateTime(
        now.year, now.month, now.day, activity.analytics.getLastStartTime().hour,
        activity.analytics.getLastStartTime().minute);

    return Scaffold(
      backgroundColor: Colours.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colours.black,
        ),
        title: Text("Analytics",
            style: new TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colours.black)),
        backgroundColor: Colours.white,
        elevation: 0,
      ),
      body: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Average Completion Time",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colours.darkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Text(
                    timer.getCurrentTime(),
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Last Start Time",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colours.darkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Text(
                    new DateFormat().add_jm().format(storedTime),
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "You take on average " + timer.getCurrentTime() +
                        " to complete this activity, and you last started at "
                        + new DateFormat().add_jm().format(storedTime) + ".",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

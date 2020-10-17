import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/activity/timer/custom_timer.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/screens/display_activities.dart';

class ActivityTimer extends StatefulWidget {

  // Activity we are timing
  final Activity activity;

  ActivityTimer(this.activity);

  @override
  _ActivityTimerState createState() => _ActivityTimerState(this.activity);
}

class _ActivityTimerState extends State<ActivityTimer> {

  // Activity we are timing
  final Activity activity;

  _ActivityTimerState(this.activity);

  // Timer to increment timer
  Timer _timer;
  CustomTimer timeData = new CustomTimer();

  @override
  void initState() {
    super.initState();

    setState(() {
      // Auto start timer
      toggleTimer();

      // Log start time
      this.activity.analytics.logStartTime(TimeOfDay.now());
    });
  }

  // Either start or stop timer depending on whether it's going
  void toggleTimer() {
    const oneSec = const Duration(seconds: 1);

    setState(() {
      if (_timer == null) {
        _timer = new Timer.periodic(
          oneSec,
              (Timer timer) =>
              setState(() {
                timeData.increment();
              },
              ),
        );
      } else {
        // "Pause" timer
        _timer.cancel();
        _timer = null;
      }
    });
  }

  // Stop the timer and log
  void stopTimer() {
    if (_timer != null) {
      // Log time to analytics
      activity.analytics.logDuration(timeData.duration);

      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Stop timer
          stopTimer();
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
                title: Text('Start Activity')
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    timeData.getCurrentTime(),
                    style: TextStyle(fontSize: 24),
                  ),
                  RaisedButton(
                    onPressed: () {
                      toggleTimer();
                    },
                    child: Text(this._timer == null ? "Start" : "Pause"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // Finish timer
                      stopTimer();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new Home()));
                    },
                    child: Text(
                      "Finish",
                      style: TextStyle(color: Colors.red),),
                  ),
                ],
              ),
            )
        )
    );
  }
}

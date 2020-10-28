import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/activity/timer/custom_timer.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/screens/display_activities.dart';

import '../colours.dart';

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
          (Timer timer) => setState(
            () {
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
          backgroundColor: Colours.white,
          appBar: AppBar(
            title: Text("Begin Activity",
                style: new TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colours.black)),
            backgroundColor: Colours.white,
            elevation: 0,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 140),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      activity.name,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colours.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    timeData.getCurrentTime(),
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 14, left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                      elevation: 4,
                      color: Colours.darkBlue,
                      textColor: Colours.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colours.darkBlue)),
                      onPressed: () {
                        toggleTimer();
                      },
                      child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 120),
                          child: Text(
                            this._timer == null ? "Start" : "Pause",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                      )
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                      elevation: 4,
                      color: Colours.lightRed,
                      textColor: Colours.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colours.lightRed)),
                      onPressed: () {
                        // Finish timer
                        stopTimer();

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => new Home()));
                      },
                      child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 120),
                          child: Text(
                            "Stop",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                      )
                  ),
                ),
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        )
    );
  }
}

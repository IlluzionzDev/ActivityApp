import 'package:flutter/material.dart';

class ActivityAnalytics {

  // The times taken for this activity to be completed
  List<Duration> _durations = new List();

  // Time of day the activity was started
  List<TimeOfDay> _startTimes = new List();

  void logDuration(Duration duration) {
    _durations.add(duration);
  }

  void logStartTime(TimeOfDay startTime) {
    _startTimes.add(startTime);
  }

  // Get average duration of activity
  Duration getAverageCompletion() {
    if (_durations.isEmpty)
      return new Duration(seconds: 0);

    int seconds = 0;

    // Add seconds from everything
    _durations.forEach((element) {seconds += element.inSeconds;});
    int averageSeconds = (seconds / _durations.length).round();
    return new Duration(seconds: averageSeconds);
  }

  TimeOfDay getLastStartTime() {
    // Get last in list
    return _startTimes[_startTimes.length - 1];
  }

}
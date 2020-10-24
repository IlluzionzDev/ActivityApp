import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity_analytics.dart';
import 'package:intl/intl.dart';

/// Activity data object
class Activity {
  /// Unique ID of the activity
  int id;

  /// Nice name of the activity
  String name = "New Activity";

  /// A longer outline of the activity
  String description = "";

  /// What time of the day this activity should start at
  TimeOfDay occurrenceTime = TimeOfDay.now();

  /// Store our days as integers in here
  List<bool> occurrenceDays = new List.filled(7, true);

  // Analytics for our activity
  ActivityAnalytics analytics = new ActivityAnalytics();

  /// Easy constructor
  /// This first will assign id when assigned to model
  Activity({this.name, this.id, this.description, this.occurrenceTime, this.occurrenceDays});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    occurrenceTime = new TimeOfDay(hour: json["time"]["hour"], minute: json["time"]["minute"]);

    // Load days of the week
    for (int i = 1; i <= 7; i++) {
      // Change string to boolean value
      bool active = json["days"][i.toString()].toString().toLowerCase() == "true";
      occurrenceDays[i - 1] = active;
    }

    // Load analytics
    List<dynamic> durations = json["analytics"]["durations"];
    List<dynamic> startTimes = json["analytics"]["startTimes"];

    List<Duration> activityDurations = new List();
    List<TimeOfDay> activityStartTimes = new List();

    durations.forEach((element) {
      activityDurations.add(new Duration(seconds: element));
    });

    startTimes.forEach((element) {
      activityStartTimes.add(new TimeOfDay(hour: element["hour"], minute: element["minute"]));
    });

    this.analytics = new ActivityAnalytics.manual(activityDurations, activityStartTimes);
  }

  // JSON serializable
  Map<String, dynamic> toJson() {
    var startTimes = new List();
    var durations = new List();

    analytics.startTimes.forEach((element) {
      startTimes.add({
        "hour": element.hour,
        "minute": element.minute
      });
    });

    analytics.durations.forEach((element) {
      durations.add(element.inSeconds);
    });

    return {
        "id": id,
        "name": name,
        "description": description,
        "time": {
          "hour": occurrenceTime.hour,
          "minute": occurrenceTime.minute
        },
        "days": {
          "1": occurrenceDays[0],
          "2": occurrenceDays[1],
          "3": occurrenceDays[2],
          "4": occurrenceDays[3],
          "5": occurrenceDays[4],
          "6": occurrenceDays[5],
          "7": occurrenceDays[6]
        },
        "analytics": {
          "durations": durations,
          "startTimes": startTimes
        }
      };
  }

  String getDisplayTime() {
    if (occurrenceTime == null)
      this.occurrenceTime = TimeOfDay.now();

    final now = new DateTime.now();
    DateTime storedTime = new DateTime(
        now.year, now.month, now.day, occurrenceTime.hour,
        occurrenceTime.minute);
    return new DateFormat().add_jm().format(storedTime);
  }
}
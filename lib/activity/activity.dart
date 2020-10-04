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

  String getDisplayTime() {
    final now = new DateTime.now();
    DateTime storedTime = new DateTime(now.year, now.month, now.day, occurrenceTime.hour, occurrenceTime.minute);
    return new DateFormat().add_jm().format(storedTime);
  }
}
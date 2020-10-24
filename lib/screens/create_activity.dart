import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/activity/activity_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../colours.dart';

/// Dual class for creating and editing activities
class UpdateActivity extends StatefulWidget {
  // The activity to update/create
  final Activity activity;

  // If this should edit the activity or insert it
  final bool editing;

  UpdateActivity(this.activity, this.editing);

  @override
  _UpdateActivityState createState() =>
      _UpdateActivityState(this.activity, this.editing);
}

class _UpdateActivityState extends State<UpdateActivity> {
  // The activity to update/create
  final Activity activity;

  // If this should edit the activity or insert it
  final bool editing;

  _UpdateActivityState(this.activity, this.editing);

  /// Hold the state of our form
  final _formKey = GlobalKey<FormState>();

  // Nicely formatted time to display
  String displayTime = new DateFormat().add_jm().format(DateTime.now());

  /// Store occurrence details here in state to update activity
  DateTime storedTime = DateTime.now();
  List<bool> occurrenceDays = new List.filled(7, true);

  @override
  void initState() {
    super.initState();

    if (this.editing) {
      final now = new DateTime.now();
      storedTime = new DateTime(now.year, now.month, now.day,
          activity.occurrenceTime.hour, activity.occurrenceTime.minute);
      displayTime = new DateFormat().add_jm().format(storedTime);
      occurrenceDays = activity.occurrenceDays;
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<ActivityModel>();

    return Scaffold(
      backgroundColor: Colours.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colours.black,
        ),
        title: Text(this.editing ? "Edit Activity" : "Create Activity",
            style: new TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colours.black)),
        backgroundColor: Colours.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter a name here...',
                      hintStyle: TextStyle(fontSize: 13),
                    ),
                    initialValue: activity.name,
                    onSaved: (value) {
                      activity.name = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must give your activity a name';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter a description here...',
                      hintStyle: TextStyle(fontSize: 13),
                    ),
                    initialValue: activity.description,
                    onSaved: (value) {
                      activity.description = value;
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Start Time",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(displayTime,
                            style: TextStyle(
                                color: Colours.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: RaisedButton(
                            elevation: 4,
                            color: Colours.darkBlue,
                            textColor: Colours.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colours.darkBlue)),
                            onPressed: () {
                              DatePicker.showTime12hPicker(context,
                                  onConfirm: (date) => {
                                        setState(() {
                                          displayTime = new DateFormat()
                                              .add_jm()
                                              .format(date);
                                        }),
                                        storedTime = date,
                                      });
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 20),
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Days",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  WeekdaySelector(
                      onChanged: (int day) {
                        setState(() {
                          final index = day % 7;
                          occurrenceDays[index] = !occurrenceDays[index];
                        });
                      },
                      elevation: 4,
                      values: occurrenceDays),
                ],
              )),
        ],
      ),
      floatingActionButton: RaisedButton(
        elevation: 4,
        color: Colours.darkBlue,
        textColor: Colours.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colours.darkBlue)),
        onPressed: () async {
          // Validate will return true if the form is valid, or false if
          // the form is invalid.
          if (_formKey.currentState.validate()) {
            // Run save callbacks on fields
            _formKey.currentState.save();

            FlutterLocalNotificationsPlugin
            flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
            NotificationDetails details = new NotificationDetails(
                AndroidNotificationDetails(
                    "test", "test", "test"),
                IOSNotificationDetails());

            // Only cancel if editing
            if (this.editing) {
              activity.occurrenceDays
                  .asMap()
                  .forEach((key, value) {
                if (value) {
                  // Cancel current pending
                  int id = activity.id + (key + 1 * 1000);
                  flutterLocalNotificationsPlugin.cancel(id);
                }
              });
            }

            // Any other additional saving
            activity.occurrenceDays = this.occurrenceDays;
            activity.occurrenceTime =
                TimeOfDay.fromDateTime(storedTime);

            // Insert or update
            if (this.editing) {
              model.update(activity);
            } else {
              /// Add to model
              model.add(activity);
            }

            this.occurrenceDays.asMap().forEach((key, value) {
              if (value) {
                // Get day from index
                Day day = Day(key + 1);
                // Generate unique id
                int id = activity.id + (key + 1 * 1000);

                flutterLocalNotificationsPlugin
                    .showWeeklyAtDayAndTime(
                    id,
                    activity.name,
                    "Don't forget to do your activity. Don't let yourself down",
                    day,
                    Time(storedTime.hour, storedTime.minute,
                        0),
                    details);
              }
            });

            model.saveToDisk();
            // model.loadFromDisk();
            Navigator.pop(context);
          }
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 120),
            child: Text(
              'Save Changes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/activity/activity_model.dart';
import 'package:flutter_app/activity/activity_popup.dart';
import 'package:flutter_app/screens/time_activity.dart';
import 'package:provider/provider.dart';

import '../colours.dart';

/// Represents an activity displayed in a list
class ActivityListObject extends StatefulWidget {
  /// Activity object to display
  final Activity activity;

  ActivityListObject(this.activity);

  @override
  _ActivityListObjectState createState() =>
      _ActivityListObjectState(this.activity);
}

class _ActivityListObjectState extends State<ActivityListObject> {
  /// Activity object to have state
  final Activity activity;

  _ActivityListObjectState(this.activity);

  @override
  Widget build(BuildContext context) {
    var model = context.watch<ActivityModel>();

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
            elevation: 4,
            color: Colours.lightBlue,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  ListTile(
                    trailing: new ActivityOptions(activity, context).getPopup(),
                    title: Text(activity.name,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colours.white,
                            fontWeight: FontWeight.bold)),
                    subtitle: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: activity.getDisplayTime(), style: TextStyle(color: Colours.white)),
                          TextSpan(text: " |", style: TextStyle(color: Colours.white)),
                          TextSpan(text: " M", style: TextStyle(color: activity.occurrenceDays[1] ? Colours.darkBlue : Colours.white)),
                          TextSpan(text: " T", style: TextStyle(color: activity.occurrenceDays[2] ? Colours.darkBlue : Colours.white)),
                          TextSpan(text: " W", style: TextStyle(color: activity.occurrenceDays[3] ? Colours.darkBlue : Colours.white)),
                          TextSpan(text: " T", style: TextStyle(color: activity.occurrenceDays[4] ? Colours.darkBlue : Colours.white)),
                          TextSpan(text: " F", style: TextStyle(color: activity.occurrenceDays[5] ? Colours.darkBlue : Colours.white)),
                          TextSpan(text: " S", style: TextStyle(color: activity.occurrenceDays[6] ? Colours.darkBlue : Colours.white)),
                          TextSpan(text: " S", style: TextStyle(color: activity.occurrenceDays[0] ? Colours.darkBlue : Colours.white)),
                        ],
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 0, right: 0, bottom: 5),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            activity.description == ""
                                ? "No Description"
                                : activity.description,
                            style:
                                TextStyle(fontSize: 15, color: Colours.white))),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      RaisedButton(
                        elevation: 4,
                        color: Colours.darkBlue,
                        textColor: Colours.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            side: BorderSide(color: Colours.darkBlue)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      new ActivityTimer(activity)));
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              'Start Activity',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

/// List to display all activities
class DisplayActivities extends StatefulWidget {
  @override
  _DisplayActivitiesState createState() => _DisplayActivitiesState();
}

class _DisplayActivitiesState extends State<DisplayActivities> {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<ActivityModel>();

    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: model.activities.length,
        itemBuilder: (context, i) {
          return new ActivityListObject(model.activities.values.toList()[i]);
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/activity/activity_model.dart';
import 'package:flutter_app/screens/time_activity.dart';
import 'package:provider/provider.dart';

import 'create_activity.dart';

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      activity.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      activity.description,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                    Text(
                      'Start Time: ' + activity.getDisplayTime(),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              )),
          FlatButton(
              onPressed: () {
                // Start activity
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new ActivityTimer(activity)));
              },
              child: Text(
                'Start Activity',
                style: TextStyle(color: Colors.blue),
              )),
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                /// Open options menu
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new UpdateActivity(
                            model.get(this.activity.id), true)));
              })
        ],
      ),
    );
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

/// Home Screen
class DisplayActivitiesHome extends StatefulWidget {
  @override
  _DisplayActivitiesHomeState createState() => _DisplayActivitiesHomeState();
}

class _DisplayActivitiesHomeState extends State<DisplayActivitiesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: new DisplayActivities(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Create new activity
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      new UpdateActivity(new Activity(), false)));
        },
        label: Text('New Activity'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

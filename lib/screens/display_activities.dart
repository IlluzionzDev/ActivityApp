import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/activity/activity_model.dart';
import 'package:provider/provider.dart';

import 'create_activity.dart';

/// Represents an activity displayed in a list
class ActivityListObject extends StatefulWidget {

  /// Activity object to display
  final Activity activity;
  ActivityListObject(this.activity);

  @override
  _ActivityListObjectState createState() => _ActivityListObjectState(this.activity);
}

class _ActivityListObjectState extends State<ActivityListObject> {

  /// Activity object to have state
  final Activity activity;
  _ActivityListObjectState(this.activity);

  @override
  Widget build(BuildContext context) {
    var model = context.watch<ActivityModel>();

    return ListTile(
      title: Text(
          this.activity.name
      ),
      subtitle: this.activity.description.trim() == "" ? null : Text(this.activity.description),
      trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {
        /// Open options menu
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new UpdateActivity(model.get(this.activity.id), true))
        );
      }),
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
              MaterialPageRoute(builder: (context) => new UpdateActivity(new Activity(), false))
          );
        },
        label: Text('New Activity'),
        icon: Icon(Icons.add),
      ),
    );
  }
}


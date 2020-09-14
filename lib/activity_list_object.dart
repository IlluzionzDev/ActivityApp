import 'package:flutter/material.dart';

import 'activity.dart';

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
    return Container();
  }
}
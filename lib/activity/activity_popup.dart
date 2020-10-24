import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/screens/create_activity.dart';
import 'package:provider/provider.dart';

import '../colours.dart';
import 'activity_model.dart';

// Custom popup options
class ActivityOptions {
  final Activity _activity;
  final BuildContext _context;

  ActivityModel model;

  ActivityOptions(this._activity, this._context) {
    model = _context.watch<ActivityModel>();
  }

  PopupMenuButton getPopup() {
    return PopupMenuButton<ActivityOption>(
      child: Icon(Icons.settings, color: Colours.white),
      onSelected: (ActivityOption result) {
        if (result == ActivityOption.EDIT) {
          Navigator.push(
              _context,
              MaterialPageRoute(
                  builder: (context) =>
                  new UpdateActivity(_activity, true)));
        } else if (result == ActivityOption.DELETE) {
          this.model.remove(_activity.id);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ActivityOption>>[
        const PopupMenuItem<ActivityOption>(
          value: ActivityOption.EDIT,
          child: Text('Edit'),
        ),
        const PopupMenuItem<ActivityOption>(
          value: ActivityOption.ANALYTICS,
          child: Text('Analytics'),
        ),
        const PopupMenuItem<ActivityOption>(
          value: ActivityOption.DELETE,
          child: Text('Delete'),
        ),
      ],
    );
  }
}

enum ActivityOption { EDIT, ANALYTICS, DELETE }

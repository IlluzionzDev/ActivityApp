import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screens/display_activities.dart';

import 'activity/activity_model.dart';

/// Home or display widget
// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new DisplayActivitiesHome();
//   }
// }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {

  ActivityModel model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check here for saving
    if (state == AppLifecycleState.paused) {
      if (model != null)
        model.saveToDisk();
    } else if (state == AppLifecycleState.resumed) {
      if (model != null)
        model.loadFromDisk();
    }
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch<ActivityModel>();

    return new DisplayActivitiesHome();
  }
}


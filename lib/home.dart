import 'package:flutter/material.dart';
import 'package:flutter_app/screens/create_activity.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screens/display_activities.dart';

import 'activity/activity.dart';
import 'activity/activity_model.dart';
import 'colours.dart';

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
      if (model != null) model.saveToDisk();
    } else if (state == AppLifecycleState.resumed) {
      if (model != null) model.loadFromDisk();
    }
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch<ActivityModel>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Activities',
              style: new TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colours.black)),
          backgroundColor: Colours.white,
          elevation: 0,
        ),
        body: new Scaffold(
          backgroundColor: Colours.white,
          body: new DisplayActivities(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Create new activity
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        new UpdateActivity(new Activity(), false)));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
              left: 16,
              top: 0,
              right: 16,
              bottom: 16
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colours.white),
                title: Text(
                  'Activities',
                  style: TextStyle(color: Colours.white),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add, color: Colours.white),
                title: Text('New Activity',
                    style: TextStyle(color: Colours.white)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline, color: Colours.white),
                title: Text('Info', style: TextStyle(color: Colours.white)),
              ),
            ],
            currentIndex: 0,
            selectedItemColor: Colours.lightBlue,
            selectedLabelStyle: TextStyle(color: Colours.lightBlue),
            backgroundColor: Colours.darkBlue,
          ),
        ));
  }
}

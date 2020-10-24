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
  int _currentScreen = 0;

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
          elevation: 4,
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
          padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 16),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                title: Text('Activities'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add, color: Colours.white),
                title: Text('New Activity',
                    style: TextStyle(color: Colours.white)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                title: Text('Info'),
              ),
            ],
            currentIndex: _currentScreen,
            selectedItemColor: Colours.lightBlue,
            selectedLabelStyle: TextStyle(color: Colours.lightBlue),
            selectedIconTheme: IconThemeData(color: Colours.lightBlue),
            unselectedItemColor: Colours.white,
            unselectedLabelStyle: TextStyle(color: Colours.white),
            unselectedIconTheme: IconThemeData(color: Colours.white),
            backgroundColor: Colours.darkBlue,
            onTap: (index) => {
              // Make sure not new activity button
              if (index != 1)
                setState(() {
                  _currentScreen = index;
                })
            },
          ),
        ));
  }
}

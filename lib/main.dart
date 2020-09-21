import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity_model.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  // Listen for state change on our model to update activities in application
  runApp(App());
}

/// Main application Widget, our display screen
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      // Provide widgets with our ActivityModel
      create: (context) => ActivityModel(),
      child: MaterialApp(
        title: 'Activities',
        home: Home(),
      ),
    );
  }
}
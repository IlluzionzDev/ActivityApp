import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'activity.dart';

/// Contains data for all activities in our application
class ActivityModel extends ChangeNotifier {

  // Private state of activities
  final Map<int, Activity> _activities = new Map<int, Activity>();
  // Next free id to assign activity
  int nextId = 1;

  Map<int, Activity> get activities => _activities;

  void saveToDisk() async {
    final directory = await getApplicationDocumentsDirectory();
    final dataFile = new File('${directory.path}/activities.json');

    // Create json
    Map<String, dynamic> data = new Map();
    List<dynamic> activities = new List();

    _activities.values.forEach((element) {
      activities.add(jsonEncode(element));
    });

    data.putIfAbsent("activities", () => activities);
    dataFile.writeAsString(jsonEncode(data));
  }

  void loadFromDisk() async {
    // Clear before loading
    _activities.clear();

    final directory = await getApplicationDocumentsDirectory();
    final dataFile = new File('${directory.path}/activities.json');

    String contents = await dataFile.readAsString();
    Map<String, dynamic> data = jsonDecode(contents);

    List<dynamic> activities = data["activities"];

    activities.forEach((element) {
      element = jsonDecode(element);
      _activities.putIfAbsent(element["id"], () => Activity.fromJson(element));
    });

    notifyListeners();
  }

  /// Get by id
  Activity get(int id) {
    return _activities[id];
  }

  void update(Activity activity) {
    this._activities.update(activity.id, (value) => activity);
    notifyListeners();
  }

  void add(Activity activity) {
    activity.id = nextId;
    _activities.putIfAbsent(nextId++, () => activity);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Remove by id
  void remove(int id) {
    _activities.remove(id);
    notifyListeners();
  }

  /// Removes all items from the model.
  void removeAll() {
    _activities.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

}
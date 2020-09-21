import 'package:flutter/material.dart';

import 'activity.dart';

/// Contains data for all activities in our application
class ActivityModel extends ChangeNotifier {

  // Private state of activities
  final Map<int, Activity> _activities = new Map<int, Activity>();
  // Next free id to assign activity
  int nextId = 1;

  Map<int, Activity> get activities => _activities;

  /// Get by id
  Activity get(int id) {
    return _activities[id];
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
  }

  /// Removes all items from the cart.
  void removeAll() {
    _activities.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

}
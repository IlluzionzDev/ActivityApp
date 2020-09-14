/// Activity data object
class Activity {
  /// Unique ID of the activity
  int id;

  /// Nice name of the activity
  String name = "New Activity";

  /// A longer outline of the activity
  String description = "A new activity";

  /// Easy constructor
  Activity(this.id, this.name);
  Activity.description(this.id, this.name, this.description);
}
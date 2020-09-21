/// Activity data object
class Activity {
  /// Unique ID of the activity
  int id;

  /// Nice name of the activity
  String name = "New Activity";

  /// A longer outline of the activity
  String description = "A new activity";

  /// Easy constructor
  /// This first will assign id when assigned to model
  Activity({this.name, this.id, this.description});
}
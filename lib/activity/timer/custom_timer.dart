// Class to store timer data
class CustomTimer {

  // Store time data
  Duration duration = new Duration();

  // Increment timer by one second
  void increment() {
    duration += Duration(seconds: 1);
  }

  // Get the time to display
  String getCurrentTime() {
    return '${duration.inHours}' + 'h ' + '${duration.inMinutes.remainder(60)}' + 'm ' + '${duration.inSeconds.remainder(60)}' + 's';
  }

}
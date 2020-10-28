import 'package:flutter/material.dart';

// Screen to display info about application
class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
          "Memory loss is an issue rising amongst the elderly, or people who have been involved in traumatic incidents. This"
              " can often lead to bad consequences like forgetting when to take medicine, or forgetting important exercise."
          " This app can help be a solution to this problem. It helps you remember to do stuff constantly, helping lock it"
          " into your brain. The repetition increased your cognitive ability to remember it, and subtlety other things may start"
              " to come back too. Even if memory isn't a problem this can help with making sure you stick to a routine of doing"
              " certain things such as exercise, seeing friends, or anything else you struggle to do constantly. So give this app a try"
              " and you'll be surprised by the benefits."
          , style: TextStyle(fontSize: 18)),
    );
  }
}

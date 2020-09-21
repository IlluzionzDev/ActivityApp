import 'package:flutter/material.dart';
import 'package:flutter_app/activity/activity.dart';
import 'package:flutter_app/activity/activity_model.dart';
import 'package:provider/provider.dart';

class CreateActivity extends StatefulWidget {
  @override
  _CreateActivityState createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  /// Hold the state of our form
  final _formKey = GlobalKey<FormState>();
  /// Object to create
  Activity activity = Activity();


  @override
  Widget build(BuildContext context) {
    var model = context.watch<ActivityModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Activity'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                  onSaved: (value) {
                    activity.name = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must give your activity a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  onSaved: (value) {
                    activity.description = value;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        // Run save callbacks on fields
                        _formKey.currentState.save();
                        /// Add to model
                        model.add(activity);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Create'),
                  ),
                ),
              ],
            )
        ),
      )
    );
  }
}

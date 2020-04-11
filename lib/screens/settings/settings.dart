import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings_screen';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchListTile.adaptive(
          onChanged: (bool value) {
            Provider.of<SettingsProvider>(context, listen: false)
                .toggleDarkMode(value);
          },
          value: Provider.of<SettingsProvider>(context).isDarkMode,
          secondary: Icon(Icons.brightness_6),
          title: const Text('Dark Mode'),
        ),
        RaisedButton(
            child: const Text('Tap to produce error (test crashlytics)'),
            onPressed: () {
              // Use Crashlytics to throw an error. Use this for
              // confirmation that errors are being correctly reported.
              Crashlytics.instance.crash();
            }),
        RaisedButton(
            child:
                const Text('Tap to produce uncaught error (test crashlytics)'),
            onPressed: () {
              // Example of thrown error, it will be caught and sent to
              // Crashlytics.
              throw StateError('Uncaught error thrown by app.');
            }),
      ],
    );
  }
}

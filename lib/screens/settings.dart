import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/overview.dart';
import 'package:lta_datamall_flutter/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {
              Navigator.pushNamed(context, Overview.id);
            },
          ),
          title: const Text('Settings'),
        ),
        body: ListView(
          children: <Widget>[
            SwitchListTile.adaptive(
              onChanged: (bool value) {
                Provider.of<SettingsProvider>(context, listen: false)
                    .toggleDarkMode(value);
              },
              value: Provider.of<SettingsProvider>(context).isDarkMode,
              secondary: Icon(Icons.brightness_6),
              title: const Text('Dark Mode'),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/widgets/main_app_drawer.dart';
import 'package:lta_datamall_flutter/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        drawer: MainAppDrawer(),
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

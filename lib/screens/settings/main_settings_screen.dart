import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/providers/settings_provider.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';
import 'package:lta_datamall_flutter/services/bus/bus_favorites_service_provider.dart';
import 'package:provider/provider.dart';

class MainSettingsScreen extends StatelessWidget {
  static const String id = 'main_settings_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          SwitchListTile.adaptive(
            onChanged: (bool value) {
              Provider.of<SettingsServiceProvider>(context, listen: false)
                  .toggleDarkMode(value);
            },
            value: Provider.of<SettingsServiceProvider>(context).isDarkMode,
            secondary: Icon(Icons.brightness_6),
            title: const Text('Dark Mode'),
          ),
          Builder(
            builder: (BuildContext ctx) => RaisedButton(
              onPressed: () {
                Provider.of<BusFavoritesServiceProvider>(context, listen: false)
                    .clearBusStops();

                Scaffold.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text('Favorites have been reset!'),
                  ),
                );
              },
              child: const Text('Reset Favorites'),
            ),
          ),
        ],
      ),
    );
  }
}

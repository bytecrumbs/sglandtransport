import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter_v2/components/main_app_drawer.dart';
import 'package:lta_datamall_flutter_v2/providers/settings_provider.dart';
import 'package:lta_datamall_flutter_v2/screens/settings.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'LTA Datamall App',
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              brightness:
                  settings.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            initialRoute: Overview.id,
            routes: {
              Overview.id: (context) => Overview(),
              Settings.id: (context) => Settings(),
            },
          );
        },
      ),
    );
  }
}

class Overview extends StatelessWidget {
  static const String id = 'overview_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
      ),
      drawer: MainAppDrawer(),
      body: Center(
        child: const Text('Body'),
      ),
    );
  }
}

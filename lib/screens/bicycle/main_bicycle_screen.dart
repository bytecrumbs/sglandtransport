import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';

class MainBicycleScreen extends StatelessWidget {
  static const String id = 'main_bicycle_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bicycles'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.directions_bike,
              size: 70,
            ),
            const Text('Coming soon!'),
          ],
        ),
      ),
    );
  }
}

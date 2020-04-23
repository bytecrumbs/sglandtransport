import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';

class MainTaxiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxis'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.local_taxi,
              size: 70,
            ),
            const Text('Coming soon!'),
          ],
        ),
      ),
    );
  }
}

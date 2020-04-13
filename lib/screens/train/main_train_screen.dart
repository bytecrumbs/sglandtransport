import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';

class MainTrainScreen extends StatelessWidget {
  static const String id = 'main_train_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trains'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.train,
              size: 70,
            ),
            const Text('Coming soon!'),
          ],
        ),
      ),
    );
  }
}

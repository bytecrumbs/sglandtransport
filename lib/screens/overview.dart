import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/widgets/main_app_drawer.dart';

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
        child: const Text('Overview'),
      ),
    );
  }
}

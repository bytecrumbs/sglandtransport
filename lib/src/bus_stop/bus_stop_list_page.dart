import 'package:flutter/material.dart';
import 'bus_stop_page.dart';

class BusStopListPage extends StatelessWidget {
  const BusStopListPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buses 2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.restorablePushNamed(
              context,
              BusStopPage.routeName,
              // TODO: Hardcoding of argument name! check how to change this
              arguments: {'busStopCode': '78129'},
            );
          },
          child: const Text('Bus Arrival'),
        ),
      ),
    );
  }
}

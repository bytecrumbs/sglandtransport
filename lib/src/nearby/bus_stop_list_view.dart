import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/src/arrival/bus_arrival_screen_arguments.dart';
import '../arrival/bus_arrival_list_view.dart';

class BusStopListView extends StatelessWidget {
  const BusStopListView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buses'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.restorablePushNamed(
              context,
              BusArrivalListView.routeName,
              arguments: {'busStopNumber': 'asdf'},
            );
          },
          child: const Text('Bus Arrival'),
        ),
      ),
    );
  }
}

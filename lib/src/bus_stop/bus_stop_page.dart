import 'package:flutter/material.dart';

class BusStopPage extends StatelessWidget {
  const BusStopPage({Key? key, required this.busStopCode}) : super(key: key);

  static const routeName = '/busStop';

  final String busStopCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrival'),
      ),
      body: const Center(
        child: Text('Arrival'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/src/arrival/bus_arrival_controller.dart';

class BusArrivalListView extends StatefulWidget {
  const BusArrivalListView({
    Key? key,
    required this.controller,
    required this.busStopNumber,
  }) : super(key: key);

  static const routeName = '/busArrival';

  final BusArrivalController controller;
  final String busStopNumber;

  @override
  State<BusArrivalListView> createState() => _BusArrivalListViewState();
}

class _BusArrivalListViewState extends State<BusArrivalListView> {
  @override
  void initState() {
    super.initState();
    widget.controller.init(widget.busStopNumber);
  }

  @override
  void dispose() {
    widget.controller.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Arrival'),
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          if (widget.controller.busNumbers == null) {
            return const Center(
              child: Text('Loading...'),
            );
          } else {
            return Center(
              child: Text(widget.controller.busNumbers.toString()),
            );
          }
        },
      ),
    );
  }
}

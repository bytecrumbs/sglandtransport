import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_details.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/utils.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    @required this.serviceNo,
    @required this.nextBusLoad,
    @required this.nextBus2Load,
    @required this.nextBus3Load,
  });

  final String serviceNo;
  final Map<String, String> nextBusLoad;
  final Map<String, String> nextBus2Load;
  final Map<String, String> nextBus3Load;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: ExpansionTile(
        title: ListTile(
          leading: CircleAvatar(child: Text(serviceNo)),
          title: Text(Utility().getTimeToBusStop(
            nextBusLoad['estimatedArrival'],
          )),
        ),
        children: <Widget>[
          BusArrivalDetails(busDetails: nextBusLoad),
          BusArrivalDetails(busDetails: nextBus2Load),
          BusArrivalDetails(busDetails: nextBus3Load)
        ],
      ),
    );
  }
}

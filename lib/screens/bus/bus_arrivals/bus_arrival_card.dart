import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_details.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/utils.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    @required this.serviceNo,
    @required this.nextBus,
    @required this.nextBus2,
    @required this.nextBus3,
  });

  final String serviceNo;
  final Map<String, String> nextBus;
  final Map<String, String> nextBus2;
  final Map<String, String> nextBus3;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: ExpansionTile(
        title: ListTile(
          leading: CircleAvatar(child: Text(serviceNo)),
          title: Text(Utility().getTimeToBusStop(
            nextBus['estimatedArrival'],
          )),
        ),
        children: <Widget>[
          BusArrivalDetails(
            feature: nextBus['feature'],
            load: nextBus['load'],
            estimatedArrival: nextBus['estimatedArrival'],
          ),
          BusArrivalDetails(
            feature: nextBus2['feature'],
            load: nextBus2['load'],
            estimatedArrival: nextBus2['estimatedArrival'],
          ),
          BusArrivalDetails(
            feature: nextBus3['feature'],
            load: nextBus3['load'],
            estimatedArrival: nextBus3['estimatedArrival'],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_details.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/utils.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    @required this.serviceNo,
    @required this.nextBusesDetails,
  });

  final String serviceNo;
  final Map<String, Map> nextBusesDetails;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: ExpansionTile(
        title: ListTile(
          leading: CircleAvatar(child: Text(serviceNo)),
          title: Text(Utility().getTimeToBusStop(
            nextBusesDetails['nextBus']['estimatedArrival'] as String,
          )),
        ),
        children: <Widget>[
          BusArrivalDetails(busDetails: nextBusesDetails['nextBus']),
          BusArrivalDetails(busDetails: nextBusesDetails['nextBus2']),
          BusArrivalDetails(busDetails: nextBusesDetails['nextBus3'])
        ],
      ),
    );
  }
}

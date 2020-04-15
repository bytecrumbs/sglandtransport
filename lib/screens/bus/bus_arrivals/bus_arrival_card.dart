import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/utils.dart';
import 'package:lta_datamall_flutter/widgets/boxInfo.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard(
      {@required this.serviceNo,
      @required this.nextBusEstimatedArrival,
      @required this.nextBus2EstimatedArrival,
      @required this.nextBus3EstimatedArrival,
      @required this.nextBusLoad,
      @required this.nextBusType,
      @required this.nextBusFeature});

  final String serviceNo;
  final String nextBusEstimatedArrival;
  final String nextBus2EstimatedArrival;
  final String nextBus3EstimatedArrival;
  final String nextBusLoad;
  final String nextBusType;
  final String nextBusFeature;

  @override
  Widget build(BuildContext context) {
    final String estimatedArrivalNextTwoBus =
        '${Utility().getTimeToBusStop(nextBus2EstimatedArrival)}, ${Utility().getTimeToBusStop(nextBus3EstimatedArrival)}';

    final String mainTiming =
        Utility().getTimeToBusStop(nextBusEstimatedArrival, true);

    String _getBusFeature(dynamic wab) {
      return wab == 'WAB'
          ? 'Wheelchair Accessible'
          : 'Non-Wheelchair Accessible';
    }

    String _getBusLoad(dynamic load) {
      final Map<String, String> _busLoad = <String, String>{
        'SEA': 'Seats Available',
        'SDA': 'Standing Available',
        'LSD': 'Limited Standing',
      };

      return load == '' ? 'N/A' : _busLoad[load];
    }

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                BoxInfo(
                  color: Theme.of(context).primaryColorDark,
                  child: Text(
                    serviceNo,
                    style: const TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_getBusLoad(nextBusLoad)),
                      Text(_getBusFeature(nextBusFeature)),
                    ])
              ],
            ),
            BoxInfo(
              color: Theme.of(context).primaryColorLight,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      mainTiming,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        estimatedArrivalNextTwoBus,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

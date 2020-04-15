import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/utils.dart';
import 'package:lta_datamall_flutter/widgets/boxInfo.dart';

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
    final String estimatedArrivalNextTwoBus =
        '${Utility().getTimeToBusStop(nextBus2['estimatedArrival'])}, ${Utility().getTimeToBusStop(nextBus3['estimatedArrival'])}';

    final String mainTiming =
        Utility().getTimeToBusStop(nextBus['estimatedArrival'], true);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

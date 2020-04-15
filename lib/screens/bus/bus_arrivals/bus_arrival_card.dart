import 'package:flutter/material.dart';
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
    final String estimatedArrivalNextTwoBus =
        '${Utility().getTimeToBusStop(nextBus2['estimatedArrival'])}, ${Utility().getTimeToBusStop(nextBus3['estimatedArrival'])}';

    final String mainTiming =
        Utility().getTimeToBusStop(nextBus['estimatedArrival'], true);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: const Alignment(0.0, 0.0),
              constraints: const BoxConstraints(minWidth: 90),
              height: 65,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Theme.of(context).primaryColorDark,
              ),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                serviceNo,
                style: const TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 90),
              height: 65,
              alignment: const Alignment(0.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Theme.of(context).primaryColorLight,
              ),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
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
  //   return ListTileTheme(
  //     contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
  //     child: ExpansionTile(
  //       title: ListTile(
  //         leading: CircleAvatar(child: Text(serviceNo)),
  //         title: Text(Utility().getTimeToBusStop(
  //           nextBus['estimatedArrival'],
  //         )),
  //       ),
  //       children: <Widget>[
  //         BusArrivalDetails(
  //           feature: nextBus['feature'],
  //           load: nextBus['load'],
  //           estimatedArrival: nextBus['estimatedArrival'],
  //         ),
  //         BusArrivalDetails(
  //           feature: nextBus2['feature'],
  //           load: nextBus2['load'],
  //           estimatedArrival: nextBus2['estimatedArrival'],
  //         ),
  //         BusArrivalDetails(
  //           feature: nextBus3['feature'],
  //           load: nextBus3['load'],
  //           estimatedArrival: nextBus3['estimatedArrival'],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

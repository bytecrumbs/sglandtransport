import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals.dart';

class BusStops extends StatelessWidget {
  static const String id = 'bus_stops_screen';
  @override
  Widget build(BuildContext context) {
    const List<String> busStops = <String>[
      '343234',
      '111222',
      '342342',
      '543543',
      '653211',
    ];

    return ListView(
      children: <Widget>[
        for (String busStop in busStops)
          OpenContainer(
            transitionType: ContainerTransitionType.fade,
            openBuilder: (BuildContext _, VoidCallback openContainer) {
              return BusArrivals();
            },
            tappable: false,
            closedShape: const RoundedRectangleBorder(),
            closedElevation: 0.0,
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return ListTile(
                leading: Icon(Icons.departure_board),
                onTap: openContainer,
                title: Text(busStop),
                trailing: Icon(Icons.assignment),
              );
            },
          ),
      ],
    );
  }
}

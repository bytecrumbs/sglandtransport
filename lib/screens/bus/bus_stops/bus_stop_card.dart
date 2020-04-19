import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen_arguments.dart';

class BusStopCard extends StatelessWidget {
  const BusStopCard({
    @required this.busStopModel,
  });

  final BusStopModel busStopModel;

  void dismissFocus(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: ListTile(
        leading: Icon(Icons.departure_board),
        title: Text('${busStopModel.busStopCode} (${busStopModel.roadName})'),
        subtitle: Text(busStopModel.description),
        trailing: Icon(Icons.assignment),
        onTap: () {
          dismissFocus(context);
          Navigator.pushNamed(
            context,
            BusArrivalsScreen.id,
            arguments: BusArrivalsScreenArguments(
              busStopModel: busStopModel,
            ),
          );
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';
import 'package:lta_datamall_flutter/utils/keyboard.dart';

class BusStopCard extends StatelessWidget {
  const BusStopCard({
    Key key,
    @required this.busStopModel,
  }) : super(key: key);

  final BusStopModel busStopModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: ListTile(
        leading: Icon(Icons.departure_board),
        title:
            Text('${busStopModel.description} (${busStopModel.busStopCode})'),
        subtitle: Text(busStopModel.roadName),
        trailing: Icon(Icons.assignment),
        onTap: () {
          Keyboard.dismiss(context);
          ExtendedNavigator.of(context).pushNamed(
            Routes.busArrivalsScreenRoute,
            arguments: BusArrivalsScreenArguments(
              busStopModel: busStopModel,
            ),
          );
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';
import 'package:lta_datamall_flutter/utils/keyboard.dart';
import 'package:lta_datamall_flutter/widgets/box_info.dart';

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
        trailing: TrailingWidget(
          distanceInMeters: busStopModel.distanceInMeters,
        ),
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

class TrailingWidget extends StatelessWidget {
  const TrailingWidget({
    Key key,
    @required this.distanceInMeters,
  }) : super(key: key);

  final int distanceInMeters;

  @override
  Widget build(BuildContext context) {
    final myDistanceInMeters = distanceInMeters ?? -1;
    if (myDistanceInMeters > 0) {
      return BoxInfo(
        color: Theme.of(context).highlightColor,
        child: Column(
          children: <Widget>[
            Text(
              myDistanceInMeters.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('meters'),
          ],
        ),
      );
    } else {
      return Icon(Icons.assignment);
    }
  }
}

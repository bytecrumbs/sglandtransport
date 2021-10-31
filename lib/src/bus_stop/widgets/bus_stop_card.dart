import 'package:flutter/material.dart';

import '../bus_repository.dart';
import '../bus_stop_page.dart';

class BusStopCard extends StatelessWidget {
  const BusStopCard({
    Key? key,
    required this.busStopValueModel,
  }) : super(key: key);

  final BusStopValueModel busStopValueModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(busStopValueModel.descritption ?? ''),
        subtitle: Text(
            '${busStopValueModel.busStopCode ?? ""} | ${busStopValueModel.roadName ?? ""}'),
        trailing: Text('${busStopValueModel.distanceInMeters.toString()} m'),
        onTap: () {
          Navigator.restorablePushNamed(
            context,
            BusStopPage.routeName,
            // TODO: Hardcoding of argument name! check how to change this
            arguments: {'busStopCode': busStopValueModel.busStopCode ?? ''},
          );
        },
      ),
    );
  }
}

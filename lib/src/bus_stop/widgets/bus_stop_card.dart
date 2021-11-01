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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (busStopValueModel.distanceInMeters != null)
              Text('${busStopValueModel.distanceInMeters.toString()} m'),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ],
        ),
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

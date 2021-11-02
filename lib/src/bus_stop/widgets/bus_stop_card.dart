import 'package:flutter/material.dart';

import '../../shared/widgets/substring_highlight.dart';
import '../bus_repository.dart';
import '../bus_stop_page.dart';

class BusStopCard extends StatelessWidget {
  const BusStopCard({
    Key? key,
    required this.busStopValueModel,
    this.searchTerm = '',
  }) : super(key: key);

  final BusStopValueModel busStopValueModel;
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: SubstringHighlight(
          text: busStopValueModel.description ?? '',
          term: searchTerm,
        ),
        subtitle: SubstringHighlight(
          text:
              '${busStopValueModel.busStopCode ?? ""} | ${busStopValueModel.roadName ?? ""}',
          term: searchTerm,
        ),
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
            arguments: {
              'busStopCode': busStopValueModel.busStopCode ?? '',
              'description': busStopValueModel.description ?? ''
            },
          );
        },
      ),
    );
  }
}

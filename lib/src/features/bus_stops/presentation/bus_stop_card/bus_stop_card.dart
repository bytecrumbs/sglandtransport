import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../../../constants/palette.dart';
import '../../../bus_services/presentation/bus_stop/bus_services_list_screen.dart';
import '../../../home/presentation/dashboard_screen.dart';
import 'bus_stop_distance.dart';

class BusStopCard extends ConsumerWidget {
  const BusStopCard({
    super.key,
    this.searchTerm = '',
  });
  final String searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStopValueModel = ref.watch(busStopValueModelProvider);
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListTile(
        title: SubstringHighlight(
          text: busStopValueModel.description ?? '',
          textStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
          term: searchTerm,
        ),
        subtitle: SubstringHighlight(
          text:
              '${busStopValueModel.busStopCode ?? ""} | ${busStopValueModel.roadName ?? ""}',
          textStyle: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: kSecondaryColor),
          term: searchTerm,
        ),
        trailing: BusStopDistance(
          distanceInMeters: busStopValueModel.distanceInMeters,
        ),
        onTap: () {
          Navigator.restorablePushNamed(
            context,
            BusServicesListScreen.routeName,
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

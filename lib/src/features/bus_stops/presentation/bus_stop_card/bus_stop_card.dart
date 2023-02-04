import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../../../constants/palette.dart';
import '../../../../routing/app_router.dart';
import '../../../home/presentation/dashboard_screen.dart';
import 'bus_stop_distance.dart';

class BusStopCard extends ConsumerWidget {
  const BusStopCard({
    super.key,
    this.searchTerm = '',
    this.isBusArrival = false,
  });
  final String searchTerm;
  final bool isBusArrival;

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
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
          term: searchTerm,
        ),
        subtitle: SubstringHighlight(
          text:
              '${busStopValueModel.busStopCode ?? ""} | ${busStopValueModel.roadName ?? ""}',
          textStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: kSecondaryColor),
          term: searchTerm,
        ),
        trailing: !isBusArrival
            ? BusStopDistance(
                distanceInMeters: busStopValueModel.distanceInMeters,
              )
            : null,
        onTap: !isBusArrival
            ? () => context.goNamed(
                  AppRoute.busServices.name,
                  params: {
                    'busStopCode': busStopValueModel.busStopCode ?? '',
                  },
                )
            : null,
      ),
    );
  }
}

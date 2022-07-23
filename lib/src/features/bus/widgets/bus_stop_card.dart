import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../../constants/palette.dart';
import '../bus_stop_page_view.dart';
import '../dashboard_page_view.dart';

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
            BusStopPageView.routeName,
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

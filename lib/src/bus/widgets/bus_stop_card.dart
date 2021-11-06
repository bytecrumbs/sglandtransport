import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/palette.dart';
import '../../shared/widgets/substring_highlight.dart';
import '../bus_stop_list_page_view.dart';
import '../bus_stop_page_view.dart';

class BusStopCard extends ConsumerWidget {
  const BusStopCard({
    Key? key,
    this.searchTerm = '',
  }) : super(key: key);
  final String searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStopValueModel = ref.watch(busStopValueModelProvider);
    return Card(
      child: ListTile(
        title: SubstringHighlight(
          text: busStopValueModel.description ?? '',
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
          term: searchTerm,
        ),
        subtitle: SubstringHighlight(
          text:
              '${busStopValueModel.busStopCode ?? ""} | ${busStopValueModel.roadName ?? ""}',
          textStyle: const TextStyle(color: kSecondaryColor),
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

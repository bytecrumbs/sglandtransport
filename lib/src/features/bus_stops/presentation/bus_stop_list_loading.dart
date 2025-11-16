import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/db_init_notifier.dart';

class BusStopListLoading extends ConsumerWidget {
  const BusStopListLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDBInitiating = ref.watch(dBInitProvider);

    if (isDBInitiating.isInitializing) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isDBInitiating.busStopsStatus),
              Text(isDBInitiating.busServicesStatus),
              Text(isDBInitiating.busRoutesStatus),
            ],
          ),
        ),
      );
    } else {
      return const SliverFillRemaining(
        child: Center(child: Text('Looking for nearby bus stops...')),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';

final locationDataProvider = StreamProvider.autoDispose<LocationData>((ref) {
  var locationService = ref.read(locationServiceProvider);

  return locationService.getLocationStream();
});

class BusView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var locationData = useProvider(locationDataProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Bus View'),
        ),
        body: locationData.when(
          data: (locationData) => Center(
            child: Text('BusView ${locationData.latitude}'),
          ),
          loading: () => Center(child: const CircularProgressIndicator()),
          error: (error, stack) => const Text('Oops'),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_nearby_stream_viewmodel.dart';

class BusNearbyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusNearByStreamViewModel>.reactive(
      builder: (context, model, child) => Center(
        child: model.isBusy || model.currentLocation.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: model.currentLocation.length,
                itemBuilder: (BuildContext context, int index) {
                  return BusStopView(
                    busStopModel: model.currentLocation[index],
                    key: ValueKey<String>('busStopCard-$index'),
                  );
                }),
      ),
      viewModelBuilder: () => BusNearByStreamViewModel(),
    );
  }
}

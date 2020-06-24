import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_nearby_viewmodel.dart';

class BusNearbyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusNearbyViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: model.isBusy
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: model.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return BusStopView(
                    busStopModel: model.data[index],
                    key: ValueKey<String>('busStopCard-$index'),
                  );
                }),
      ),
      viewModelBuilder: () => BusNearbyViewModel(),
    );
  }
}

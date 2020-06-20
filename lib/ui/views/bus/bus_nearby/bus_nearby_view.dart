import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bus_nearby_viewmodel.dart';

class BusNearbyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusNearbyViewModel>.reactive(
        builder: (context, model, child) => Center(
              // model will indicate busy until the future is fetched
              child: model.isBusy
                  ? CircularProgressIndicator()
                  : Text(model.nearByBusStops.length.toString()),
            ),
        viewModelBuilder: () => BusNearbyViewModel(),
        // createNewModelOnInsert: true,
        onModelReady: (model) async {
          await model.initialize();
        });
  }
}

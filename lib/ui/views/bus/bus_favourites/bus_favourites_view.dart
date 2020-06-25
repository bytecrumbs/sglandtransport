import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_favourites_viewmodel.dart';

class BusFavouritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusFavouritesViewModel>.reactive(
      builder: (context, model, child) => Center(
        // model will indicate busy until the future is fetched
        child: model.favouriteBusStops.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemBuilder: (context, index) => BusStopView(
                  busStopModel: model.favouriteBusStops[index],
                ),
                itemCount: model.favouriteBusStops.length,
              ),
      ),
      viewModelBuilder: () => BusFavouritesViewModel(),
      onModelReady: (model) async {
        await model.initialize();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stops/bus_stop_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_favourites_viewmodel.dart';

class BusFavouritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusFavouritesViewModel>.reactive(
      builder: (context, model, child) => Center(
        // model will indicate busy until the future is fetched
        child: model.isBusy
            ? CircularProgressIndicator()
            : !model.hasError
                ? ListView.builder(
                    itemBuilder: (context, index) => BusStopView(
                      busStopModel: model.data[index],
                    ),
                    itemCount: model.data.length,
                  )
                : Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text(
                      model.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
      ),
      viewModelBuilder: () => BusFavouritesViewModel(),
    );
  }
}

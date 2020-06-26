import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/shared/favourites_icon/favourites_icon_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_arrival_service_card_view.dart';
import 'bus_arrival_viewmodel.dart';

class BusArrivalView extends StatelessWidget {
  BusArrivalView({
    @required this.busStopCode,
    @required this.description,
  });
  final String busStopCode;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusArrivalViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(description),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FavouritesIconView(busStopCode: busStopCode),
            ),
          ],
        ),
        body: Center(
          child: model.isBusy
              ? CircularProgressIndicator()
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: model.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentBusService = model.data[index];
                    return BusArrivalServiceCardView(
                      key: ValueKey<String>('busArrivalCard-$index'),
                      busArrivalServiceModel: currentBusService,
                    );
                  },
                ),
        ),
      ),
      viewModelBuilder: () => BusArrivalViewModel(busStopCode),
    );
  }
}

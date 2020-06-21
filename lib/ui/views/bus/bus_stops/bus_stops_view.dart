import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:stacked/stacked.dart';
import 'bus_stop_view.dart';
import 'bus_stops_viewmodel.dart';

class BusStopsView extends StatelessWidget {
  final UserLocation userLocation;

  BusStopsView({@required this.userLocation});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusStopsViewModel>.reactive(
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
      viewModelBuilder: () => BusStopsViewModel(userLocation),
    );
  }
}

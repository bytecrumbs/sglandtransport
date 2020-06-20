import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_arrival/bus_arrival_viewmodel.dart';
import 'package:lta_datamall_flutter/ui/views/shared/favourites_icon/favourites_icon_view.dart';
import 'package:stacked/stacked.dart';

class BusArrivalView extends StatelessWidget {
  BusArrivalView({@required this.busStopCode});
  final String busStopCode;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusArrivalViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Bus Arrival'),
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
              : Text(model.data.length.toString()),
        ),
      ),
      viewModelBuilder: () => BusArrivalViewModel(busStopCode),
    );
  }
}

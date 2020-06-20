import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_arrival/bus_arrival_viewmodel.dart';
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
        ),
        body: Center(
          child: Text(busStopCode),
        ),
      ),
      viewModelBuilder: () => BusArrivalViewModel(),
    );
  }
}

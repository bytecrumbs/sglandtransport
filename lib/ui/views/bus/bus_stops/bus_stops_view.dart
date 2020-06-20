import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:stacked/stacked.dart';
import 'bus_stops_viewmodel.dart';

class BusStopsView extends StatelessWidget {
  final List<BusStopModel> busStopList;

  BusStopsView({@required this.busStopList});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusStopsViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: ListView.builder(
            itemCount: model.busStopList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(6),
                child: ListTile(
                  leading: Icon(Icons.departure_board),
                  title: Text(model.busStopList[index].description),
                  subtitle: Text(
                      '${model.busStopList[index].busStopCode} | ${model.busStopList[index].roadName}'),
                  onTap: () {},
                ),
              );
            }),
      ),
      onModelReady: (model) async {
        await model.initialize(busStopList);
      },
      viewModelBuilder: () => BusStopsViewModel(),
    );
  }
}

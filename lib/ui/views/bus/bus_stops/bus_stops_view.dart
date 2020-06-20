import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:stacked/stacked.dart';
import 'bus_stop_view.dart';
import 'bus_stops_viewmodel.dart';

class BusStopsView extends StatelessWidget {
  final List<BusStopModel> busStopList;
  static final _log = Logger('BusService');

  BusStopsView({@required this.busStopList});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusStopsViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: ListView.builder(
            itemCount: model.busStopList.length,
            itemBuilder: (BuildContext context, int index) {
              return BusStopView(
                busStopModel: model.busStopList[index],
                key: ValueKey<String>('busStopCard-$index'),
              );
            }),
      ),
      onModelReady: (model) async {
        _log.info('::BusStopsView - onModelReady');
        await model.initialize(busStopList);
      },
      viewModelBuilder: () => BusStopsViewModel(),
    );
  }
}

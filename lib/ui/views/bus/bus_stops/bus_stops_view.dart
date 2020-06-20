import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/ui/views/shared/box_info/box_info_view.dart';
import 'package:stacked/stacked.dart';
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
              return Card(
                margin: const EdgeInsets.all(6),
                child: ListTile(
                  leading: Icon(Icons.departure_board),
                  title: Text(model.busStopList[index].description),
                  subtitle: Text(
                    '${model.busStopList[index].busStopCode} | ${model.busStopList[index].roadName}',
                  ),
                  trailing: _buildBoxInfo(context, model, index),
                  onTap: () {},
                ),
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

  BoxInfo _buildBoxInfo(
      BuildContext context, BusStopsViewModel model, int index) {
    return BoxInfo(
      color: Theme.of(context).highlightColor,
      child: Column(
        children: <Widget>[
          Text(
            model.busStopList[index].distanceInMeters.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text('meters'),
        ],
      ),
    );
  }
}

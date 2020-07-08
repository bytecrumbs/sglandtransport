import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view_model.dart';
import 'package:stacked/stacked.dart';

class BusStopView extends StatelessWidget {
  const BusStopView({
    Key key,
    @required this.busStopModel,
  }) : super(key: key);

  final BusStopModel busStopModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusStopViewModel>.nonReactive(
      builder: (context, model, child) => Card(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 12),
        child: ListTile(
          title: Container(
            margin: EdgeInsets.only(bottom: 3),
            child: Text(
              busStopModel.description,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          subtitle: Text(
            '${busStopModel.busStopCode} | ${busStopModel.roadName}',
            style: Theme.of(context).textTheme.headline2,
          ),
          trailing: busStopModel.distanceInMeters != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${busStopModel.distanceInMeters.toString()} m',
                        style: TextStyle(fontSize: 15)),
                  ],
                )
              : null,
          onTap: () {
            model.navigateToBusArrival(
              busStopModel.busStopCode,
              busStopModel.description,
            );
          },
        ),
      ),
      viewModelBuilder: () => BusStopViewModel(),
    );
  }
}

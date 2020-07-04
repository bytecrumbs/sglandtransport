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
              style: TextStyle(
                  color: Color.fromRGBO(37, 48, 77, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          subtitle: Text(
            '${busStopModel.roadName} (${busStopModel.busStopCode})',
            style: TextStyle(
                color: Color.fromRGBO(140, 140, 145, 1),
                fontSize: 16,
                fontWeight: FontWeight.w100),
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

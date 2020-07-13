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
          contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          busStopModel.description,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Text(
                        '${busStopModel.busStopCode} | ${busStopModel.roadName}',
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                ),
              ),
              busStopModel.distanceInMeters != null
                  ? Center(
                      child: Text(
                        '${busStopModel.distanceInMeters.toString()} m',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  : Text('')
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Theme.of(context).accentColor,
          ),
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

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'bus_nearby_stream_viewmodel.dart';

class BusNearbyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusNearByStreamViewModel>.reactive(
      builder: (context, model, child) => Center(
        child: model.isBusy || model.nearByBusStopList.isEmpty
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 320,
                      child: FlareActor("images/city.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.fitHeight,
                          animation: "Loop"),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: model.nearByBusStopList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return BusStopView(
                                busStopModel: model.nearByBusStopList[index],
                                key: ValueKey<String>('busStopCard-$index'),
                              );
                            }))
                  ],
                ),
              ),
      ),
      viewModelBuilder: () => BusNearByStreamViewModel(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:lta_datamall_flutter/ui/views/shared/staggered_animation/staggered_animation.dart';
import 'package:stacked/stacked.dart';
import 'bus_nearby_viewmodel.dart';

class BusNearbyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusNearByViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: model.isBusy || model.nearByBusStopList.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : AnimationLimiter(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.nearByBusStopList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StaggeredAnimation(
                      index: index,
                      child: BusStopView(
                        busStopModel: model.nearByBusStopList[index],
                        key: ValueKey<String>('busStopCard-$index'),
                      ),
                    );
                  },
                ),
              ),
      ),
      viewModelBuilder: () => BusNearByViewModel(),
      onModelReady: (model) {
        model.initialise();
      },
    );
  }
}

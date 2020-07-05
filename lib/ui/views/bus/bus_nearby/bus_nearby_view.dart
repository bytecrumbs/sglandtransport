import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/provider/asset_flare.dart';

import 'bus_nearby_viewmodel.dart';

class BusNearbyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final asset = AssetFlare(bundle: rootBundle, name: 'images/city.flr');

    return ViewModelBuilder<BusNearByViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: model.isBusy || model.nearByBusStopList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text('Nearby Buses'),
                    pinned: true,
                    floating: false,
                    snap: false,
                    expandedHeight: 290.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        height: 320,
                        child: FlareCacheBuilder(
                          [asset],
                          builder: (BuildContext context, bool isWarm) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 320,
                              child: FlareActor.asset(
                                asset,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                                animation: 'Loop',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      List.generate(
                        model.nearByBusStopList.length,
                        (index) => AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 200),
                          child: SlideAnimation(
                            verticalOffset: 20.0,
                            child: FadeInAnimation(
                              child: BusStopView(
                                busStopModel: model.nearByBusStopList[index],
                                key: ValueKey<String>('busStopCard-$index'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      viewModelBuilder: () => BusNearByViewModel(),
    );
  }
}

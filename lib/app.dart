import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart' as http;
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/models/user_location.dart';
import 'package:lta_datamall_flutter/providers/bus/favorite_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/bus/nearby_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/bus/search_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/location_provider.dart';
import 'package:lta_datamall_flutter/providers/observer_provider.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<List<BusStopModel>> _busStopList =
      fetchBusStopList(http.IOClient());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BusStopModel>>(
      future: _busStopList,
      builder:
          (BuildContext context, AsyncSnapshot<List<BusStopModel>> snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(
            providers: <SingleChildWidget>[
              Provider<ObserverProvider>(
                create: (_) => ObserverProvider(),
              ),
              ChangeNotifierProvider<NearbyBusStopsProvider>(
                create: (_) =>
                    NearbyBusStopsProvider(allBusStops: snapshot.data),
              ),
              ChangeNotifierProvider<FavoriteBusStopsProvider>(
                create: (_) =>
                    FavoriteBusStopsProvider(allBusStops: snapshot.data),
              ),
              ChangeNotifierProvider<SearchBusStopsProvider>(
                create: (_) =>
                    SearchBusStopsProvider(allBusStops: snapshot.data),
              ),
              StreamProvider<UserLocation>(
                create: (_) => LocationProvider().locationStream,
              )
            ],
            child: Consumer<ObserverProvider>(
              builder: (
                BuildContext context,
                ObserverProvider observer,
                _,
              ) {
                return ExtendedNavigator<Router>(
                  initialRoute: Routes.mainBusScreenRoute,
                  router: Router(),
                  observers: <NavigatorObserver>[
                    observer.getAnalyticsObserver(),
                  ],
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          Text(snapshot.error.toString());
        }
        return Loader();
      },
    );
  }
}

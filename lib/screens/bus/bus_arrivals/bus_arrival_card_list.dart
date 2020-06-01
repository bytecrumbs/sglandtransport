import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/db/database_provider.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card.dart';

class BusArrivalCardList extends StatefulWidget {
  const BusArrivalCardList({@required this.busStopCode});

  final String busStopCode;

  @override
  _BusArrivalCardListState createState() => _BusArrivalCardListState();
}

class _BusArrivalCardListState extends State<BusArrivalCardList> {
  Future<BusArrivalModel> _busArrivalModel;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _busArrivalModel =
        DatabaseProvider.dbProvider.getBusArrivalList(widget.busStopCode);
    // _busArrivalModel = fetchBusArrivalList(http.IOClient(), widget.busStopCode);
    timer = Timer.periodic(
      const Duration(minutes: 1),
      (Timer t) => _refresh(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _refresh() {
    setState(() {
      // _busArrivalModel =
      //     fetchBusArrivalList(http.IOClient(), widget.busStopCode);
      _busArrivalModel =
          DatabaseProvider.dbProvider.getBusArrivalList(widget.busStopCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _busArrivalModel,
      builder: (context, AsyncSnapshot<BusArrivalModel> snapshot) {
        if (snapshot.hasData) {
          return _buildListView(snapshot.data.services);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  ListView _buildListView(List<BusArrivalServiceModel> busServices) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: busServices.length,
      itemBuilder: (BuildContext context, int index) {
        final currentBusService = busServices[index];
        return BusArrivalCard(
          key: ValueKey<String>('busArrivalCard-$index'),
          busArrivalServiceModel: currentBusService,
        );
      },
    );
  }
}

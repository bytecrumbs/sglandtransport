import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:http/io_client.dart' as http;

class BusArrivalCardList extends StatelessWidget {
  const BusArrivalCardList({@required this.busStopCode});

  final String busStopCode;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchBusArrivalList(http.IOClient(), busStopCode),
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

import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_header.dart';
import 'package:http/io_client.dart' as http;

class BusArrivalCardList extends StatefulWidget {
  const BusArrivalCardList({@required this.busStopCode});

  final String busStopCode;

  @override
  _BusArrivalCardListState createState() => _BusArrivalCardListState();
}

class _BusArrivalCardListState extends State<BusArrivalCardList> {
  Future<BusArrivalModel> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchBusArrivalList(http.IOClient(), widget.busStopCode);
  }

  Future<BusArrivalModel> _refreshBusArrivals() {
    setState(() {
      _future = fetchBusArrivalList(http.IOClient(), widget.busStopCode);
    });

    return _future;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const BusArrivalHeader(
              headerText: 'Buses',
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _refreshBusArrivals();
              },
            )
          ],
        ),
        Expanded(
          child: FutureBuilder<BusArrivalModel>(
            future: _future,
            builder: (BuildContext context,
                AsyncSnapshot<BusArrivalModel> snapshot) {
              if (snapshot.hasData) {
                final List<BusArrivalServiceModel> busServices =
                    snapshot.data.services;
                return RefreshIndicator(
                  onRefresh: _refreshBusArrivals,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: busServices.length,
                    itemBuilder: (BuildContext context, int index) {
                      final BusArrivalServiceModel currentBusService =
                          busServices[index];
                      return BusArrivalCard(
                        serviceNo: currentBusService.serviceNo,
                        busOperator: currentBusService.busOperator,
                        nextBusType: currentBusService.nextBus.type,
                        nextBusLoad: currentBusService.nextBus.load,
                        estimatedArrival:
                            currentBusService.nextBus.estimatedArrival,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                // TODO(sascha): do something here
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}

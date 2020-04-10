import 'package:flutter/material.dart';
import 'package:http/io_client.dart' as http;
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals/bus_arrival_card.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals/bus_arrival_header.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals/bus_stop_info_header.dart';

class BusArrivalsScreen extends StatefulWidget {
  const BusArrivalsScreen({
    @required this.busStopCode,
    @required this.description,
    @required this.roadName,
  });

  static const String id = 'bus_arrivals_screen';

  final String busStopCode;
  final String description;
  final String roadName;

  @override
  _BusArrivalsScreenState createState() => _BusArrivalsScreenState();
}

class _BusArrivalsScreenState extends State<BusArrivalsScreen> {
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

  // TODO(sascha): also display information for the next 2 buses arriving
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Arrivals'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _refreshBusArrivals();
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          BusStopInfoHeader(
            busStopCode: widget.busStopCode,
            description: widget.description,
            roadName: widget.roadName,
          ),
          // TODO(sascha): Extract into its own Stateful widget
          const BusArrivalHeader(
            headerText: 'Buses',
          ),
          Expanded(
            child: FutureBuilder<BusArrivalModel>(
              future: _future,
              builder: (BuildContext context,
                  AsyncSnapshot<BusArrivalModel> snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data.busStopCode);
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
          )
        ],
      ),
    );
  }
}

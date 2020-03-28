import 'package:flutter/material.dart';
import 'package:http/io_client.dart' as http;
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';

class BusArrivals extends StatefulWidget {
  const BusArrivals({
    @required this.busStopCode,
    @required this.description,
    @required this.roadName,
  });

  static const String id = 'bus_arrivals_screen';

  final String busStopCode;
  final String description;
  final String roadName;

  @override
  _BusArrivalsState createState() => _BusArrivalsState();
}

class _BusArrivalsState extends State<BusArrivals> {
  Future<BusArrivalModel> _future;

  final Map<String, String> _busType = <String, String>{
    'SD': 'Single Deck',
    'DD': 'Double Deck',
    'BD': 'Bendy',
  };

  @override
  void initState() {
    super.initState();
    _future = fetchBusArrivalList(http.IOClient(), widget.busStopCode);
  }

  int _getArrivalInMinutes(String arrivalTime) {
    final DateTime nextArrivalTime = DateTime.parse(arrivalTime);
    return nextArrivalTime.difference(DateTime.now()).inMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Arrivals'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(6),
            child: const Text(
              'Bus Stop',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(6),
            child: ListTile(
              title: Text('${widget.busStopCode} (${widget.description})'),
              subtitle: Text(widget.roadName),
            ),
          ),
          Container(
            child: const Text(
              'Buses',
              style: TextStyle(fontSize: 16.0),
            ),
            margin: const EdgeInsets.all(6),
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
                  return ListView.builder(
                    itemCount: busServices.length,
                    itemBuilder: (BuildContext context, int index) {
                      final BusArrivalServiceModel currentBusService =
                          busServices[index];
                      final int arrivalInMinutes = _getArrivalInMinutes(
                          currentBusService.nextBus.estimatedArrival);
                      return Card(
                        margin: const EdgeInsets.all(6),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(currentBusService.serviceNo),
                          ),
                          title: Text(
                            '${currentBusService.busOperator} - ${_busType[currentBusService.nextBus.type]}',
                          ),
                          trailing: Text(
                            arrivalInMinutes <= 0
                                ? 'Arr'
                                : "${arrivalInMinutes.toString()}'",
                          ),
                        ),
                      );
                    },
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

import 'package:flutter/material.dart';

class BusArrivalCard extends StatelessWidget {
  BusArrivalCard({
    @required this.serviceNo,
    @required this.busOperator,
    @required this.nextBusType,
    @required this.nextBusLoad,
    @required this.estimatedArrival,
  });

  final String serviceNo;
  final String busOperator;
  final String nextBusType;
  final String nextBusLoad;
  final String estimatedArrival;

  final Map<String, String> _busType = <String, String>{
    'SD': 'Single Deck',
    'DD': 'Double Deck',
    'BD': 'Bendy',
  };
  final Map<String, String> _busLoad = <String, String>{
    'SEA': 'Seats Available',
    'SDA': 'Standing Available',
    'LSD': 'Limited Standing',
  };

  String _getArrivalInMinutes(String arrivalTime) {
    final DateTime nextArrivalTime = DateTime.parse(arrivalTime);
    final int arrivalInMinutes =
        nextArrivalTime.difference(DateTime.now()).inMinutes;
    return arrivalInMinutes <= 0 ? 'Arr' : arrivalInMinutes.toString();
  }

  @override
  Widget build(BuildContext context) {
    final String arrivalInMinutes = _getArrivalInMinutes(estimatedArrival);
    return Card(
      margin: const EdgeInsets.all(6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(serviceNo),
        ),
        title: Text(
          '$busOperator - ${_busType[nextBusType]}',
        ),
        subtitle: Text(
          _busLoad[nextBusLoad],
        ),
        trailing: Text(
          arrivalInMinutes,
        ),
      ),
    );
  }
}

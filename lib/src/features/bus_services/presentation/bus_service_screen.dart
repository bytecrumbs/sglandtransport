import 'package:flutter/material.dart';

import '../../bus_routes/presentation/bus_route.dart';
import 'bus_service_details.dart';

class BusServiceScreen extends StatelessWidget {
  const BusServiceScreen({
    super.key,
    required this.serviceNo,
    required this.busStopCode,
    required this.destinationCode,
  });

  final String serviceNo;
  final String busStopCode;
  final String destinationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus $serviceNo Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BusServiceDetails(
            destinationCode: destinationCode,
            serviceNo: serviceNo,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BusRoute(
              busStopCode: busStopCode,
              destinationCode: destinationCode,
              serviceNo: serviceNo,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bus_service_details.dart';
import 'bus_service_route.dart';

class BusServiceScreen extends ConsumerWidget {
  const BusServiceScreen({
    super.key,
    required this.serviceNo,
    required this.busStopCode,
  });

  final String serviceNo;
  final String busStopCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus $serviceNo Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BusServiceDetails(
            busStopCode: busStopCode,
            serviceNo: serviceNo,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BusServiceRoute(
              busStopCode: busStopCode,
              serviceNo: serviceNo,
            ),
          ),
        ],
      ),
    );
  }
}

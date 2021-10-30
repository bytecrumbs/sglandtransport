import 'package:flutter/material.dart';

import '../bus_repository.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    Key? key,
    required this.busArrivalModel,
  }) : super(key: key);

  final BusArrivalServicesModel busArrivalModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(busArrivalModel.serviceNo),
      ),
    );
  }
}
